import 'package:sqflite/sqflite.dart';
import 'dbhelper.dart';

class TodoDB {
  static Future<List<Map<String, dynamic>>> getAllToDos() async {
    final database = await DBHelper.getDatabase();
    return database.rawQuery('''SELECT 
          todo.id,
          todo.title,
          todo.done,
          todo.duedate,
          todo.create_date
        FROM todo
        ''');
  }

  static Future<void> insertToDo(Map<String, dynamic> data) async {
    final database = await DBHelper.getDatabase();
    data['create_date'] =
        DateTime.now().toIso8601String(); // Add the current date
    await database.insert("todo", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteToDo(int id) async {
    final database = await DBHelper.getDatabase();
    await database.rawDelete("""DELETE FROM todo WHERE id=?""", [id]);
  }

  static Future<void> setDone(int id, bool flag) async {
    final database = await DBHelper.getDatabase();
    int value = flag ? 1 : 0;
    await database
        .rawUpdate("""UPDATE todo SET done=? WHERE id=?""", [value, id]);
  }

  static Future<void> updateToDoTitle(int id, String title) async {
    final database = await DBHelper.getDatabase();
    await database
        .rawUpdate("""UPDATE todo SET title=? WHERE id=?""", [title, id]);
  }

  static Future<void> updateToDo(int id, {String? title, bool? done}) async {
    final database = await DBHelper.getDatabase();
    Map<String, dynamic> updateData = {};

    if (title != null) {
      updateData['title'] = title;
    }

    if (done != null) {
      int value = done ? 1 : 0;
      updateData['done'] = value;
    }

    await database.update("todo", updateData, where: "id = ?", whereArgs: [id]);
  }
}
