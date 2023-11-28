import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: white_color,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
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
          contentPadding: EdgeInsets.all(30),
          content: Container(
            height: 150,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 10),
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
                      backgroundColor: MaterialStateProperty.all(purple_color),
                      fixedSize: MaterialStateProperty.all(
                          Size(150, 40)), // Adjust the size as needed
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'إلغاء',
                    style: TextStyle(color: purple_color),
                  ),
                ),
                ElevatedButton(
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(purple_color),
                  ),
                  child: Text(
                    'إضافة',
                    style: TextStyle(color: white_color),
                  ),
                ),
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
          // Your existing background image code
          // ...body: Stack(
          Image.asset(
            background_image, // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          Column(
            children: [
              SizedBox(height: 150),
              Padding(
                padding: EdgeInsets.all(10.0),
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
                        SizedBox(width: 20),
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
              SizedBox(
                height: 150,
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
                        color: purple_color,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: blue_color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonTextStyle: TextStyle().copyWith(
                        color: white_color,
                        fontSize: 15.0,
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
                child: ListView.builder(
                  reverse: false,
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButtonBox('قائمة الطعام', food_image, () {
                    // Handle the button click for 'List of Food'
                  }),
                  _buildButtonBox('قائمة الحضور', invitation_image, () {
                    // Handle the button click for 'List of Guests'
                  }),
                  _buildButtonBox('الميزانية ', rings_image, () {
                    // Handle the button click for 'Expense Tracker'
                  }),
                ],
              ),
            ],
          ),
        ],
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
                onPressed: () {},
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

  Widget _buildButtonBox(
      String title, String imagePath, VoidCallback onPressed) {
    return Container(
      width: 100,
      height: 120,
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
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
