import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class SwipingCalendar extends StatefulWidget {
  @override
  _SwipingCalendarState createState() => _SwipingCalendarState();
}

class _SwipingCalendarState extends State<SwipingCalendar> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add width and height constraints if needed
      child: Column(
        children: [
          CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              setState(() {
                _selectedDate = date;
              });
            },
            weekendTextStyle: TextStyle(color: Colors.red),
            thisMonthDayBorderColor: Colors.grey,
            daysTextStyle: TextStyle(color: Colors.white),
            todayButtonColor: Colors.transparent,
            todayBorderColor: Colors.green,
            selectedDateTime: _selectedDate,
          ),
          SizedBox(height: 16),
          Text('Selected Date: ${_selectedDate.toLocal()}'),
        ],
      ),
    );
  }
}
