import 'package:notes_app1/core/constants.dart';
import 'package:notes_app1/data/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), Constants.dbName);
    return await openDatabase(
      path,
      version: Constants.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Constants.tableNotes} (
        ${Constants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constants.columnTitle} TEXT NOT NULL,
        ${Constants.columnContent} TEXT NOT NULL,
        ${Constants.columnCreatedAt} TEXT NOT NULL,
        ${Constants.columnUpdatedAt} TEXT NOT NULL
      )
    ''');
  }

  // CRUD Operations

  // Create
  Future<int> insertNote(Note note) async {
    Database db = await database;
    return await db.insert(Constants.tableNotes, note.toMap());
  }

  // Read all
  Future<List<Note>> getNotes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      Constants.tableNotes,
      orderBy: '${Constants.columnUpdatedAt} DESC',
    );
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  // Read single note
  Future<Note?> getNote(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      Constants.tableNotes,
      where: '${Constants.columnId} = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    }
    return null;
  }

  // Update
  Future<int> updateNote(Note note) async {
    Database db = await database;
    return await db.update(
      Constants.tableNotes,
      note.toMap(),
      where: '${Constants.columnId} = ?',
      whereArgs: [note.id],
    );
  }

  // Delete
  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.delete(
      Constants.tableNotes,
      where: '${Constants.columnId} = ?',
      whereArgs: [id],
    );
  }
}