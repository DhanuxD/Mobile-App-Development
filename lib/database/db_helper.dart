import 'package:mobile_app/models/note.dart';
import 'package:mobile_app/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "auth.db";

  //User Table//
  String user = '''
   CREATE TABLE users (
   usrId INTEGER PRIMARY KEY AUTOINCREMENT,
   fullName TEXT,
   email TEXT,
   usrName TEXT UNIQUE,
   usrPassword TEXT
   )
   ''';

  String note =
      "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL);";

//Note Table//

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(user);
      await db.execute(note);
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Add logic for upgrading the database schema here
        print("Upgrading database to add note table");
        await db.execute(note);
      }
    });
  }

  //Authentication
  Future<bool> authenticate(Users usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from users where usrName = '${usr.usrName}' AND usrPassword = '${usr.password}' ");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> createUser(Users usr) async {
    final Database db = await initDB();
    return db.insert("users", usr.toMap());
  }

  //Get current User details
  Future<Users?> getUser(String usrName) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "usrName = ?", whereArgs: [usrName]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  //Add note
  static Future<int> addNote(Note note) async {
    final db = await DatabaseHelper().initDB();
    return await db.insert("note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//Update note
  static Future<int> updateNote(Note note) async {
    final db = await DatabaseHelper().initDB();
    return await db.update("note", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Delete Note
  static Future<int> deleteNote(Note note) async {
    final db = await DatabaseHelper().initDB();
    return await db.delete(
      "note",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //Get all notes
  static Future<List<Note>?> getAllNotes() async {
    final db = await DatabaseHelper().initDB();

    final List<Map<String, dynamic>> maps = await db.query("note");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }
}
