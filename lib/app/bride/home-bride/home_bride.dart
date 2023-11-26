import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Color(0xE5EEF2),
        ),
        borderRadius: BorderRadius.circular(20.0), // Set border radius
      ),
      child: Card(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    todoItem.description,
                    style: TextStyle(
                      color: todoItem.isDone ? Colors.green : null,
                      fontFamily: 'changa',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '${_formatDate(todoItem.date)}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'changa',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
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
                  activeColor: Colors.green,
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
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          content: Container(
            height: 150, // Set the desired height
            child: Column(
              children: [
                TextField(
                  controller: _todoController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'أدخل مهمتك',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    hintStyle: TextStyle(),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
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
                  child: Text('اختر تاريخ'),
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
              child: Text('إضافة'),
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
            'assets/background.png', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              SizedBox(height: 150),
              Row(
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
                      SizedBox(width: 20), // Add 20px margin to the left
                      Text(
                        'قائمة المهام',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ChangaMedium',
                          color: Color(0xFF334155),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 150, // Set the desired height for the calendar
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
                      outsideTextStyle: TextStyle(color: Colors.grey),
                      selectedDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 132, 226, 244),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color(
                          0xFFD8C2FF,
                        ), // Light purple background for the current day
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonTextStyle: TextStyle().copyWith(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      formatButtonDecoration: BoxDecoration(
                        color: Color(0xD8C2FF),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      leftChevronIcon: Icon(Icons.chevron_left_outlined,
                          color: Color(0xFF00B4D8)),
                      rightChevronIcon: Icon(Icons.chevron_right_outlined,
                          color: Color(0xFF00B4D8)),
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
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)],
        ),
        child: BottomAppBar(
          color: Colors.white, // Set the bottom navigation bar color to white
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.grid_on_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.star_border_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person_outlined),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
