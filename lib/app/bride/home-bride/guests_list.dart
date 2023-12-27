import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';
import '../../../databases/dbhelper.dart';
import '../../../databases/db_guests.dart';

TextEditingController _numberOfFamilyMembersController =
    TextEditingController();

enum AttendanceStatus {
  willAttend,
  willNotAttend,
  notConfirmedYet,
}

class Guest {
  final int id; // Add ID for database identification
  final String name;
  final int numberOfFamilyMembers;
  AttendanceStatus attendanceStatus;

  Guest({
    required this.id,
    required this.name,
    required this.numberOfFamilyMembers,
    required this.attendanceStatus,
  });
}

class GuestsPage extends StatefulWidget {
  @override
  _GuestsPageState createState() => _GuestsPageState();
}

class _GuestsPageState extends State<GuestsPage> {
  List<Guest> _guestList = [];
  List<Guest> _displayedGuestList = [];
  TextEditingController _guestNameController = TextEditingController();

  @override
  void dispose() {
    _numberOfFamilyMembersController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadGuests(); // Load guests from the database when the page is initialized
  }

  Future<void> _loadGuests() async {
    final database = await GuestDBHelper.getDatabase();
    final List<Map<String, dynamic>> guestsData =
        await database.query('guests');

    setState(() {
      _guestList = guestsData.map((guestData) {
        return Guest(
          id: guestData['id'],
          name: guestData['name'],
          numberOfFamilyMembers: guestData['numberOfFamilyMembers'],
          attendanceStatus:
              AttendanceStatus.values[guestData['attendanceStatus']],
        );
      }).toList();

      _updateDisplayedGuestList(); // Update the displayed list if needed
      _displayedGuestList = List.from(_guestList);
    });
  }

// New method to directly update a guest in _guestList
  void _updateGuestInList(int guestId, AttendanceStatus newStatus) {
    final index = _guestList.indexWhere((guest) => guest.id == guestId);
    if (index != -1) {
      setState(() {
        _guestList[index].attendanceStatus = newStatus;
        _updateDisplayedGuestList(); // Update the displayed list if needed
        _displayedGuestList = List.from(_guestList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            background_image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: dark_color),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 120),
                  Text(
                    'قائمة الضيوف',
                    style: TextStyle(color: dark_color, fontSize: 18),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatusButton(
                      'سيحضر',
                      blue_color,
                      AttendanceStatus.willAttend,
                    ),
                    _buildStatusButton(
                      'لن يحضر',
                      purple_color,
                      AttendanceStatus.willNotAttend,
                    ),
                    _buildStatusButton(
                      'لم يتم التأكيد',
                      gray_color,
                      AttendanceStatus.notConfirmedYet,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: _displayedGuestList.isEmpty
                      ? Center(
                          child: Text(
                            'لا يوجد ضيوف.',
                            style: TextStyle(color: white_color),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _displayedGuestList.length,
                          itemBuilder: (context, index) {
                            return _buildGuestItem(
                                context, _displayedGuestList[index]);
                          },
                        )),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddGuestDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: blue_color,
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(
            currentPageIndex: 0, parentContext: context),
      ),
    );
  }

  Widget _buildStatusButton(
      String title, Color color, AttendanceStatus status) {
    return ElevatedButton(
      onPressed: () {
        // Logic to filter and display guests based on the selected status
        setState(() {
          _displayedGuestList = _filterGuestsByStatus(status);
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        fixedSize: MaterialStateProperty.all(
          Size(110, 40),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: white_color),
      ),
    );
  }

  List<Guest> _filterGuestsByStatus(AttendanceStatus status) {
    return _guestList
        .where((guest) => guest.attendanceStatus == status)
        .toList();
  }

  Widget _buildGuestItem(BuildContext context, Guest guest) {
    TextEditingController nameController = TextEditingController();

    nameController.text = guest.name;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          _showChangeStatusDialog(context, guest);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(white_color),
          fixedSize: MaterialStateProperty.all(
            Size(double.infinity, 50),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete, color: dark_color),
                    onPressed: () {
                      _showDeleteGuestConfirmationDialog(context, guest);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: dark_blue_color),
                    onPressed: () {
                      _showEditGuestDialog(context, guest, nameController);
                    },
                  ),
                ],
              ),
              Text(
                guest.name,
                style: TextStyle(color: dark_color),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditGuestDialog(
      BuildContext context, Guest guest, TextEditingController nameController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تعديل الضيف'),
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          content: Container(
            height: 120,
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'اسم الضيف',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: gray_color,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                String updatedName = nameController.text.trim();

                if (updatedName.isNotEmpty) {
                  // Update the guest name in the database
                  await GuestDB.updateGuestName(guest.id, updatedName);

                  // Reload guests from the database
                  // Add your logic to refresh the guest list as needed
                  _loadGuests(); // <--- Ensure this line is working as expected

                  // Notify the parent widget that an item has changed
                  _updateGuestInList(guest.id, guest.attendanceStatus);
                }

                Navigator.of(context).pop();
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteGuestConfirmationDialog(BuildContext context, Guest guest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الحذف'),
          content: Text('هل أنت متأكد أنك تريد حذف هذا الضيف؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                // Delete the guest from the database
                await GuestDB.deleteGuest(guest.id);

                // Reload guests from the database
                _loadGuests(); // <--- Ensure this line is working as expected

                // Notify the parent widget that an item has changed
                _updateGuestInList(guest.id, guest.attendanceStatus);
                // Add your logic to refresh the guest list as needed

                Navigator.of(context).pop();
              },
              child: Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  String _getStatusText(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.willAttend:
        return 'الحالة: سيحضر';
      case AttendanceStatus.willNotAttend:
        return 'الحالة: لن يحضر';
      case AttendanceStatus.notConfirmedYet:
        return 'الحالة: لم يتم التأكيد بعد';
    }
  }

  Widget _buildChangeStatusButton(
      String title, Color color, AttendanceStatus status,
      {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        fixedSize: MaterialStateProperty.all(
          Size(150, 30),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: white_color),
      ),
    );
  }

  void _updateDisplayedGuestList() {
    setState(() {
      _displayedGuestList = List.from(_guestList);
    });
  }

  void _changeStatus(Guest guest, AttendanceStatus newStatus) async {
    // Change the status in the database
    await GuestDB.updateGuest(
      guest.id,
      statusValue: newStatus.index,
    );

    // Update the guest status in the local list
    _updateGuestInList(guest.id, newStatus);
  }

  Future<void> _showAddGuestDialog(BuildContext context) async {
    String guestName = '';
    String numberOfFamilyMembers = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'إضافة ضيف',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          content: Container(
            height: 120,
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200,
                  height: 55,
                  child: TextField(
                    controller: _guestNameController,
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      guestName = value.trim();
                    },
                    decoration: InputDecoration(
                      hintText: 'اسم الضيف',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: gray_color,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 55,
                  child: TextField(
                    controller: _numberOfFamilyMembersController,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      numberOfFamilyMembers = value.trim();
                    },
                    decoration: InputDecoration(
                      hintText: 'عدد أفراد العائلة',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: gray_color,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 5.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: blue_color,
                      width: 2.0,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'إلغاء',
                        style: TextStyle(color: blue_color),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: blue_color,
                    boxShadow: [
                      BoxShadow(
                        color: dark_color.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 0.8,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (guestName.isNotEmpty &&
                          numberOfFamilyMembers.isNotEmpty) {
                        int numberOfMembers = int.parse(numberOfFamilyMembers);

                        // Add guest to the database
                        await GuestDB.insertGuest({
                          'name': guestName,
                          'numberOfFamilyMembers': numberOfMembers,
                          'attendanceStatus':
                              AttendanceStatus.notConfirmedYet.index,
                        });

                        // Reload guests after adding a new one
                        _loadGuests();
                      }

                      _guestNameController.clear();
                      _numberOfFamilyMembersController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'إضافة ضيف',
                        style: TextStyle(color: white_color),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

// Modify your _showChangeStatusDialog method
  Future<void> _showChangeStatusDialog(
      BuildContext context, Guest guest) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تغيير الحالة',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          content: Container(
            height: 200,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildChangeStatusButton(
                  'سيحضر',
                  blue_color,
                  AttendanceStatus.willAttend,
                  onPressed: () async {
                    // Change the status in the database
                    await GuestDB.updateGuest(
                      guest.id,
                      statusValue: AttendanceStatus.willAttend.index,
                    );

                    // Update the guest in the local list
                    _updateGuestInList(guest.id, AttendanceStatus.willAttend);

                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                _buildChangeStatusButton(
                  'لن يحضر',
                  purple_color,
                  AttendanceStatus.willNotAttend,
                  onPressed: () async {
                    // Change the status in the database
                    await GuestDB.updateGuest(
                      guest.id,
                      statusValue: AttendanceStatus.willNotAttend.index,
                    );

                    // Update the guest in the local list
                    _updateGuestInList(
                        guest.id, AttendanceStatus.willNotAttend);

                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                _buildChangeStatusButton(
                  'لم يتم التأكيد بعد',
                  gray_color,
                  AttendanceStatus.notConfirmedYet,
                  onPressed: () async {
                    // Change the status in the database
                    await GuestDB.updateGuest(
                      guest.id,
                      statusValue: AttendanceStatus.notConfirmedYet.index,
                    );

                    // Update the guest in the local list
                    _updateGuestInList(
                        guest.id, AttendanceStatus.notConfirmedYet);

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
