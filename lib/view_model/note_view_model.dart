import 'package:flutter/foundation.dart';
import 'package:notes_app1/data/database.dart';
import 'package:notes_app1/data/note_model.dart';

class NoteViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  
  List<Note> _notes = [];
  List<Note> get notes => _notes;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  NoteViewModel() {
    fetchNotes();
  }
  
  Future<void> fetchNotes() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _notes = await _dbHelper.getNotes();
    } catch (e) {
      debugPrint('Error fetching notes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> addNote(String title, String content) async {
    final now = DateTime.now();
    final note = Note(
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );
    
    try {
      final id = await _dbHelper.insertNote(note);
      final newNote = note.copyWith(id: id);
      _notes.insert(0, newNote);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding note: $e');
    }
  }
  
  Future<void> updateNote(Note note, String title, String content) async {
    final updatedNote = note.copyWith(
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    );
    
    try {
      await _dbHelper.updateNote(updatedNote);
      final index = _notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        _notes[index] = updatedNote;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating note: $e');
    }
  }
  
  Future<void> deleteNote(Note note) async {
    try {
      await _dbHelper.deleteNote(note.id!);
      _notes.removeWhere((n) => n.id == note.id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting note: $e');
    }
  }
}