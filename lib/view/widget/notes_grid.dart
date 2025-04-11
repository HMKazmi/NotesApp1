import 'package:flutter/material.dart';
import 'package:notes_app1/core/utils.dart';
import 'package:notes_app1/data/note_model.dart';
import 'package:notes_app1/view/AddScreen.dart';
import 'package:notes_app1/view_model/note_view_model.dart';
import 'package:provider/provider.dart';

class NotesGrid extends StatefulWidget {
  const NotesGrid({super.key});

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: Consumer<NoteViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.notes.isEmpty) {
            return const Center(
              child: Text(
                'No notes yet. Create one!',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: viewModel.notes.length,
            itemBuilder: (context, index) {
              final note = viewModel.notes[index];
              return NoteTile(note: note);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  final Note note;

  const NoteTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(
              'Updated: ${DateFormatter.formatDate(note.updatedAt)}',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(note: note),
            ),
          );
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Delete Note'),
                    content: const Text(
                      'Are you sure you want to delete this note?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<NoteViewModel>(
                            context,
                            listen: false,
                          ).deleteNote(note);
                          Navigator.pop(context);
                        },
                        child: const Text('DELETE'),
                      ),
                    ],
                  ),
            );
          },
        ),
      ),
    );
  }
}
