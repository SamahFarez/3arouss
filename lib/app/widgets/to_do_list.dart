import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  DateTime _selectedDay = DateTime.now();
  List<String> _tasks = [
    'Task 1',
    'Task 2',
    'Task 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(2023, 1, 1),
            lastDay: DateTime(2050, 12, 31),
            calendarFormat: CalendarFormat.week,
            availableCalendarFormats: const {
              CalendarFormat.week: 'Week',
            },
            calendarStyle: CalendarStyle(
              outsideTextStyle: TextStyle(color: Colors.grey),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 132, 226, 244),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFF00B4D8),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonTextStyle: TextStyle().copyWith(
                color: Colors.white,
                fontSize: 15.0,
              ),
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16.0),
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF00B4D8)),
              rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF00B4D8)),
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
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  // Add more details like due date, priority, etc. if needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}