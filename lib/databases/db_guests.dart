import 'package:sqflite/sqflite.dart';
import 'dbhelper.dart'; // Import your database helper

enum AttendanceStatus {
  willAttend,
  willNotAttend,
  notConfirmedYet,
}

class GuestDB {
  static const String _tableName = 'guests'; // Adjust the table name if needed

  static Future<int> getTotalMembers() async {
    final database =
        await GuestDBHelper.getDatabase(); // Update to GuestDBHelper
    final List<Map<String, dynamic>> guests = await database.query(_tableName);

    int totalMembers = 0;

    for (final guest in guests) {
      final int numMembers = guest['numberOfFamilyMembers'] ?? 0;
      totalMembers += numMembers + 1; // Add 1 for the guest
    }

    return totalMembers;
  }

  static Future<void> insertGuest(Map<String, dynamic> data) async {
    final database =
        await GuestDBHelper.getDatabase(); // Update to GuestDBHelper
    await database.insert(_tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteGuest(int id) async {
    final database = await GuestDBHelper.getDatabase();
    await database.rawDelete("""DELETE FROM $_tableName WHERE id=?""", [id]);
  }

  static Future<void> updateGuestName(int id, String name) async {
    final database = await GuestDBHelper.getDatabase();
    await database
        .rawUpdate("""UPDATE $_tableName SET name=? WHERE id=?""", [name, id]);
  }


  static Future<void> updateGuestMembersAttending(
      int id, int numMembers) async {
    final database =
        await GuestDBHelper.getDatabase(); // Update to GuestDBHelper
    await database.rawUpdate(
        """UPDATE $_tableName SET num_members_attending=? WHERE id=?""",
        [numMembers, id]);
  }

  static Future<void> updateGuest(int id,
      {String? name, int? statusValue}) async {
    final database =
        await GuestDBHelper.getDatabase(); // Update to GuestDBHelper
    Map<String, dynamic> updateData = {};

    if (name != null) {
      updateData['name'] = name;
    }

    await database.update(
      _tableName,
      {'attendanceStatus': statusValue},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
