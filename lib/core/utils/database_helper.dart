import 'package:notes/core/utils/constants.dart';
import 'package:notes/data/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = "myDatabase.db";
  static const int _databaseVersion = 1;

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
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // create tables
  _onCreate(Database db, int version) {
    db.execute('''CREATE TABLE $noteTable (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnTitle TEXT NOT NULL, 
          $columnContent TEXT NOT NULL,
          $columnCreateAt TEXT NOT NULL
          )''');
    db.execute('''CREATE TABLE $taskTable (
        $columnId INTEGER PRIMARY KEY,
         $columnTitle TEXT NOT NULL,
          $taskStatus BOOLEAN)
          ''');
  }

  Future<void> insertNote(NoteModel note) async {
    final db = await database;
    await db.insert(
      noteTable,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteModel>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> listOfMap = await db.query(noteTable);
    return listOfMap.map((item) => NoteModel.fromMap(item)).toList();
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    // db.delete(noteTable, where: 'columnId = ?', whereArgs: ['$id']);
    db.rawDelete('DELETE FROM $noteTable WHERE $columnId = ?', ['$id']);
  }

  Future<void> insertTask(String task) async {
    final db = await database;
    db.insert(
      taskTable,
      {
        columnTitle: task,
        taskStatus: false,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // return db.transaction(
    //   (action) async {
    //     await action.rawInsert(
    //         'INSERT INTO $taskTable ($columnTitle, $taskStatus) VALUES ("$task", false)');
    //   },
    // );
  }

  Future<List<Map>> getTasks() async {
    final db = await database;
    return db.rawQuery('SELECT * FROM $taskTable');
  }
}
