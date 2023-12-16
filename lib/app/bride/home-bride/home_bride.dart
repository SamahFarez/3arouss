import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import 'guests_list.dart';
import 'food_list.dart';
import 'expenses.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';
import '../../../databases/db_todo.dart';

class TodoItem {
  final int id;
  final String description;
  bool isDone;
  final DateTime date;

  TodoItem({
    required this.id,
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
        height: 65,
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: white_color,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: 65,
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 2,
              color: Colors.white, // Border color
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                width: 1,
                color: gray_color, // Border color
              ),
            ),
            child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),

              child: Row(
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
                      ],
                    ),
                  ),
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
                      side: BorderSide(color: blue_color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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

  void _addTodoToDB(String description, DateTime selectedDate) async {
    Map<String, dynamic> todoData = {
      'title': description,
      'done': 0,
      'duedate': selectedDate.toIso8601String(),
    };

    await TodoDB.insertToDo(todoData);

    _fetchTodos(_selectedDay);
  }

  void _fetchTodos(DateTime selectedDate) async {
    List<Map<String, dynamic>> todos = await TodoDB.getAllToDos();
    List<TodoItem> todoItems = [];

    for (var todo in todos) {
      DateTime todoDate = DateTime.parse(todo['duedate']);
      bool isToday = isSameDay(selectedDate, DateTime.now());

      if ((isToday && isSameDay(DateTime.now(), todoDate)) ||
          (!isToday && isSameDay(selectedDate, todoDate))) {
        todoItems.add(TodoItem(
          id: todo['id'],
          description: todo['title'],
          isDone: todo['done'] == 1,
          date: todoDate,
        ));
      }
    }

    setState(() {
      _todoList = todoItems;
    });
  }

  void _addTodo() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime selectedDate = DateTime.now(); // Initialize selectedDate here

        return Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
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
                          initialDate: selectedDate, // Use selectedDate here
                          firstDate: DateTime(2023, 1, 1),
                          lastDate: DateTime(2050, 12, 31),
                        );

                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate =
                                pickedDate; // Update selectedDate here
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue_color),
                        fixedSize: MaterialStateProperty.all(Size(80, 40)),
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
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                            vertical: 3.0, horizontal: 20.0),
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
                        String newTodo = _todoController.text.trim();
                        if (newTodo.isNotEmpty) {
                          _addTodoToDB(newTodo, selectedDate);
                        }
                        _todoController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 20.0),
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
          ),
        );
      },
    );
  }

  void _editTodoTitle(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text(
              'تحديث العنوان',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            content: Container(
              height: 90,
              width: 250,
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
                        hintText: 'العنوان الجديد',
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
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                            vertical: 3.0, horizontal: 20.0),
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
                        String newTitle = _todoController.text.trim();
                        if (newTitle.isNotEmpty) {
                          TodoDB.updateToDo(_todoList[index].id,
                              title: newTitle);
                          _fetchTodos(_selectedDay);
                        }
                        _todoController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 20.0),
                        child: Text(
                          'تحديث العنوان',
                          style: TextStyle(color: white_color),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchTodos(_selectedDay);
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
                              color: dark_color),
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
                    firstDay: DateTime.now().subtract(Duration(days: 365)),
                    lastDay: DateTime.now().add(Duration(days: 365)),
                    focusedDay: _selectedDay,
                    calendarFormat: CalendarFormat.week,
                    availableCalendarFormats: const {
                      CalendarFormat.week: 'أسبوع',
                    },
                    calendarStyle: CalendarStyle(
                      outsideTextStyle: TextStyle(color: text_gray_color),
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle, // Change the shape to rectangle
                        color: blue_color,
                      ),
                      todayDecoration: BoxDecoration(
                        color: purple_color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonTextStyle: TextStyle().copyWith(
                        color: white_color,
                        fontSize: 13.0,
                      ),
                      formatButtonDecoration: BoxDecoration(
                        color: gray_color,
                        shape: BoxShape.circle,
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

                      // Fetch and update the to-do list using the selected day
                      _fetchTodos(selectedDay);
                    },
                  ),
                ),
              ),
              Expanded(
                child: _todoList.isEmpty
                    ? Column(
                        children: [
                          Image.asset(
                            success_image,
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
                                TodoDB.setDone(_todoList[index].id,
                                    _todoList[index].isDone);
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
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  FoodListPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    }),
                    _buildButtonBox('قائمة الحضور', invitation_image, () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  GuestsPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    }),
                    _buildButtonBox('الميزانية ', rings_image, () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ExpenseTrackingPage(),
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
        child: CustomBottomNavigationBar(
            currentPageIndex: 0, parentContext: context),
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
