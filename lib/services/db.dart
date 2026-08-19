import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:google_notes/model/MyNoteModel.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDB('Notes.db');
    return _database!;
  }

  Future<Database> _initializeDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE ${NoteFields.tableName} (
        ${NoteFields.id} $idType,
        ${NoteFields.pin} $boolType,
        ${NoteFields.title} $textType,
        ${NoteFields.content} $textType,
        ${NoteFields.createdTime} $textType
      )
    ''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    final id = await db.insert(NoteFields.tableName, note.toJson());

    return note.copy(id: id);
  }

  Future<List<Note>> readNotes() async {
    final db = await instance.database;

    final result = await db.query(
      NoteFields.tableName,
      orderBy: '${NoteFields.createdTime} ASC',
    );

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<Note?> readOneNote(int id) async {
    final db = await instance.database;

    final result = await db.query(
      NoteFields.tableName,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return Note.fromJson(result.first);
  }

  Future<Note?> updateNote(Note note) async {
    final db = await instance.database;

    await db.update(
      NoteFields.tableName,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );

    return readOneNote(note.id!);
  }

  Future<void> deleteNote(int id) async {
    final db = await instance.database;

    await db.delete(
      NoteFields.tableName,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> togglePin(Note? note) async {
    if (note == null) return;

    final updatedNote = note.copy(pin: !note.pin);

    await updateNote(updatedNote);
  }

  Future closedb() async {
    final db = await instance.database;
    db.close();
  }
}
