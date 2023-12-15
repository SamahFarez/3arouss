import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _database_name = "ENSIA_MY_DB.db";
  static const _database_version = 4;
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todo (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              title TEXT, 
              done INTEGER, 
              duedate TEXT,
              create_date TEXT
            )
        ''');
      },
      version: _database_version,
      onUpgrade: (db, oldVersion, newVersion) {
        // Handle database upgrade if needed
      },
    );
    return _database!;
  }
}
