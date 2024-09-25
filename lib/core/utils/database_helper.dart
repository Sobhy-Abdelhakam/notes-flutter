import 'package:notes/data/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "myDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'note';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnContent = 'content';
  static const columnCreateAt = 'created_at';

  // make a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  // opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    // get a location using getDatabasePath()
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, _databaseName);
    // open the database
    Database database = await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
      // when creating the database, create the table
      db.execute('''CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnTitle TEXT NOT NULL, 
          $columnContent TEXT NOT NULL,
          $columnCreateAt TEXT NOT NULL
          )''');
    });
    return database;
  }

  Future<void> insertNote(NoteModel note) async {
    final db = await database;
    await db.insert(table, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<NoteModel>> getNotes() async{
    final db = await database;
    final List<Map<String,dynamic>> listOfMap= await db.query(table);
    return listOfMap.map((item) => NoteModel.fromMap(item)).toList();
  }
}
