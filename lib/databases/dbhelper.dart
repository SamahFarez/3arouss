import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDBHelper {
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

class ExpenseDBHelper {
  static const _database_name = "ENSIA_MY_EXPENSE_V1.db";
  static const _database_version = 4;
  static var _database;

  static Future getDatabase() async {
    if (_database != null) {
      return _database;
    }
    _database = openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (database, version) {
        database.execute('''
          CREATE TABLE  expenses (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              title TEXT, 
              price REAL, 
              date TEXT, 
              create_date TEXT
            )
        ''');
      },
      version: _database_version,
      onUpgrade: (db, oldVersion, newVersion) {
        // do nothing...
      },
    );
    return _database;
  }
}

class FoodDBHelper {
  static const _database_name = "Food_DB.db";
  static const _database_version = 1;
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE foods (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT, 
              type TEXT
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

class GuestDBHelper {
  static const _database_name = "Guests_DB.db";
  static const _database_version = 1;
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE guests (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT, 
              numberOfFamilyMembers INTEGER, 
              attendanceStatus INTEGER
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
