import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import 'guests_list.dart';
import 'food_list.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';

class TodoItem {
  final String description;
  bool isDone;
  final DateTime date;

  TodoItem({
    required this.description,
    required this.isDone,
    required this.date,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}

class TodoListItem extends StatelessWidget {
  final TodoItem todoItem;
  final VoidCallback onTodoToggle;

  TodoListItem({
    required this.todoItem,
    required this.onTodoToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      margin: EdgeInsets.symmetric(horizontal: 13.0, vertical: 0.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: white_color,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: gray_color,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        todoItem.description,
                        style: TextStyle(
                          color: todoItem.isDone ? dark_blue_color : null,
                          fontFamily: 'Changa',
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Flexible(
                      child: Text(
                        '${_formatDate(todoItem.date)}',
                        style: TextStyle(
                          color: dark_purple_color,
                          fontSize: 12,
                          fontFamily: 'Changa',
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Checkbox(
                  value: todoItem.isDone,
                  onChanged: (bool? value) {
                    onTodoToggle();
                  },
                  activeColor: blue_color,
                  side: BorderSide(color: Colors.blue), // Color of the border
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class BrideHomePage extends StatefulWidget {
  @override
  _BrideHomePageState createState() => _BrideHomePageState();
}

class _BrideHomePageState extends State<BrideHomePage> {
  DateTime _selectedDay = DateTime.now();
  List<TodoItem> _todoList = [];

  TextEditingController _todoController = TextEditingController();

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime selectedDate = DateTime.now();

        return AlertDialog(
          title: Text(
            'إضافة مهمة ',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          content: Container(
            height: 135,
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200,
                  height: 55,
                  child: TextField(
                    controller: _todoController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'المهمة',
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
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023, 1, 1),
                        lastDate: DateTime(2050, 12, 31),
                      );

                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(blue_color),
                      fixedSize: MaterialStateProperty.all(
                          Size(80, 40)), // Adjust the size as needed
                    ),
                    child: Text(
                      'اختر تاريخ',
                      style: TextStyle(color: white_color),
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
                      horizontal: 10.0), // Optional: Adjust margin as needed
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(100.0), // Set rounded corners
                    border: Border.all(
                      color: purple_color, // Set the border color
                      width: 2.0, // Set the border width
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0,
                          horizontal: 20.0), // Adjust padding as needed
                      child: Text(
                        'إلغاء',
                        style: TextStyle(color: purple_color),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.all(10.0), // Optional: Adjust margin as needed
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(100.0), // Set rounded corners
                    color: purple_color, // Set the background color
                    boxShadow: [
                      BoxShadow(
                        color:
                            dark_color.withOpacity(0.5), // Set the shadow color
                        spreadRadius: 1, // Set the spread radius of the shadow
                        blurRadius: 0.8, // Set the blur radius of the shadow
                        offset: Offset(0, 1), // Set the offset of the shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      String newTodo = _todoController.text.trim();
                      if (newTodo.isNotEmpty) {
                        setState(() {
                          _todoList.insert(
                            0,
                            TodoItem(
                              description: newTodo,
                              isDone: false,
                              date: selectedDate,
                            ),
                          );
                          _todoList.sort((a, b) => a.date.compareTo(b.date));
                        });
                      }
                      _todoController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0,
                          horizontal: 20.0), // Adjust padding as needed
                      child: Text(
                        'إضافة',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            background_image, // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              SizedBox(height: 190),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _addTodo();
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'قائمة المهام',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: dark_color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 135,
                child: Builder(
                  builder: (context) => TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(2023, 1, 1),
                    lastDay: DateTime(2050, 12, 31),
                    calendarFormat: CalendarFormat.week,
                    availableCalendarFormats: const {
                      CalendarFormat.week: 'أسبوع',
                    },
                    calendarStyle: CalendarStyle(
                      outsideTextStyle: TextStyle(color: gray_color),
                      selectedDecoration: BoxDecoration(
                        color: blue_color,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: purple_color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonTextStyle: TextStyle().copyWith(
                        color: white_color,
                        fontSize: 14.0,
                      ),
                      formatButtonDecoration: BoxDecoration(
                        color: gray_color,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      leftChevronIcon: Icon(Icons.chevron_left_outlined,
                          color: purple_color),
                      rightChevronIcon: Icon(Icons.chevron_right_outlined,
                          color: purple_color),
                    ),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(_selectedDay, date);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: _todoList.isEmpty
                    ? Column(
                        children: [
                          Image.asset(
                            success_image, // Replace with the actual path
                            width: 180,
                            height: 190,
                          ),
                          Text("لا توجد مهام لهذا اليوم")
                        ],
                      )
                    : ListView.builder(
                        itemCount: _todoList.length,
                        itemBuilder: (context, index) {
                          return TodoListItem(
                            todoItem: _todoList[index],
                            onTodoToggle: () {
                              setState(() {
                                _todoList[index].toggleDone();
                              });
                            },
                          );
                        },
                      ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButtonBox('قائمة الطعام', food_image, () {
                      // Handle the button click for 'List of Food'
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  FoodListPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child; // No transition animation
                          },
                        ),
                      );
                    }),
                    _buildButtonBox('قائمة الحضور', invitation_image, () {
                      // Handle the button click for 'List of Guests'
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  GuestsPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child; // No transition animation
                          },
                        ),
                      );
                    }),
                    _buildButtonBox('الميزانية ', rings_image, () {
                      // Handle the button click for 'Expense Tracker'
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  GuestsPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child; // No transition animation
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 10), //Bottom screen
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildButtonBox(
      String title, String imagePath, VoidCallback onPressed) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: white_color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: dark_color.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: dark_color,
                fontFamily: 'Changa',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
