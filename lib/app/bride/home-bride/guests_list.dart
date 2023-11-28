import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import 'home_bride.dart';
import 'package:flutter/material.dart';

enum AttendanceStatus {
  willAttend,
  willNotAttend,
  notConfirmedYet,
}

class Guest {
  final String name;
  final int numberOfFamilyMembers;
  AttendanceStatus attendanceStatus;

  Guest({
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
  TextEditingController _numberOfFamilyMembersController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayedGuestList = List.from(_guestList);
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
              SizedBox(height: 220),
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
                          return _buildGuestItem(_displayedGuestList[index]);
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddGuestDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: purple_color,
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          boxShadow: [BoxShadow(color: dark_color, blurRadius: 5)],
        ),
        child: BottomAppBar(
          color: white_color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: ImageIcon(AssetImage(home_icon)),
                onPressed: () {
                  // Navigate to BrideHomePage without transition animation
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BrideHomePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child; // No transition animation
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(categories_outlined_icon)),
                onPressed: () {},
              ),
              IconButton(
                icon: ImageIcon(AssetImage(star_outlined_icon)),
                onPressed: () {},
              ),
              IconButton(
                icon: ImageIcon(AssetImage(heart_outlined_icon)),
                onPressed: () {},
              ),
              IconButton(
                icon: ImageIcon(AssetImage(profile_outlined_icon)),
                onPressed: () {},
              ),
            ],
          ),
        ),
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

  Widget _buildGuestItem(Guest guest) {
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(guest.name,
                  style: TextStyle(color: dark_color),
                  textAlign: TextAlign.right),
            ],
          ),
        ),
      ),
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

  void _changeStatus(Guest guest, AttendanceStatus newStatus) {
    setState(() {
      guest.attendanceStatus = newStatus;
    });
  }

  void _showAddGuestDialog(BuildContext context) {
    showDialog(
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
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: purple_color,
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
                        style: TextStyle(color: purple_color),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: purple_color,
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
                    onPressed: () {
                      String guestName = _guestNameController.text.trim();
                      String numberOfFamilyMembers =
                          _numberOfFamilyMembersController.text.trim();

                      if (guestName.isNotEmpty &&
                          numberOfFamilyMembers.isNotEmpty) {
                        setState(() {
                          int numberOfMembers =
                              int.parse(numberOfFamilyMembers);
                          _guestList.add(
                            Guest(
                              name: guestName,
                              numberOfFamilyMembers: numberOfMembers,
                              attendanceStatus:
                                  AttendanceStatus.notConfirmedYet,
                            ),
                          );
                        });
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

  void _showChangeStatusDialog(BuildContext context, Guest guest) {
    showDialog(
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
                  onPressed: () {
                    _changeStatus(guest, AttendanceStatus.willAttend);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                _buildChangeStatusButton(
                  'لن يحضر',
                  purple_color,
                  AttendanceStatus.willNotAttend,
                  onPressed: () {
                    _changeStatus(guest, AttendanceStatus.willNotAttend);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                _buildChangeStatusButton(
                  'لم يتم التأكيد بعد',
                  gray_color,
                  AttendanceStatus.notConfirmedYet,
                  onPressed: () {
                    _changeStatus(guest, AttendanceStatus.notConfirmedYet);
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
