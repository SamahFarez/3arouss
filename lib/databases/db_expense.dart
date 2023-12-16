import 'package:sqflite/sqflite.dart';
import 'dbhelper.dart';

class ExpenseDB {
  static Future<List<Map<String, dynamic>>> getAllExpenses() async {
    final database = await ExpenseDBHelper.getDatabase();

    return database.rawQuery('''SELECT 
            expenses.id ,
            expenses.title,
            expenses.price,
            expenses.date
          from expenses
          ''');
  }

  static Future<double> getTotalPrice() async {
    final database = await ExpenseDBHelper.getDatabase();

    // Use querySingle to get a single result directly
    final result = await database.querySingle('''SELECT sum(expenses.price)
          FROM expenses
          ''');

    // Extract the total price from the result
    final totalPrice = result['sum(expenses.price)'] ?? 0.0;

    return totalPrice.toDouble(); // Return as double
  }

  static Future insertExpense(Map<String, dynamic> data) async {
    final database = await ExpenseDBHelper.getDatabase();
    database.insert("expenses", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future deleteExpense(int id) async {
    final database = await ExpenseDBHelper.getDatabase();
    database.rawQuery("""delete from  expenses where id=?""", [id]);
    return true;
  }

  static Future<void> updateExpense(Map<String, dynamic> data) async {
    final database = await ExpenseDBHelper.getDatabase();
    await database.update(
      'expenses',
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }
}
