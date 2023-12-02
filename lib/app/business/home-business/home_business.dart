import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../requests_business/requests_page.dart';
import '../../widgets/bottom_navigation_bar_business.dart';

class RequestItem {
  final String clientName;
  final String requestDetails;
  final DateTime date;

  RequestItem({
    required this.clientName,
    required this.requestDetails,
    required this.date,
  });
}

class RequestListItem extends StatelessWidget {
  final RequestItem requestItem;

  RequestListItem({required this.requestItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: white_color,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requestItem.clientName,
                    style: TextStyle(
                      color: dark_blue_color,
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    requestItem.requestDetails,
                    style: TextStyle(
                      color: dark_purple_color,
                      fontSize: 12,
                      fontFamily: 'Changa',
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    '${_formatDate(requestItem.date)}',
                    style: TextStyle(
                      color: dark_purple_color,
                      fontSize: 12,
                      fontFamily: 'Changa',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class BusinessHomePage extends StatefulWidget {
  final Request? acceptedRequest;

  BusinessHomePage({this.acceptedRequest});

  @override
  _BusinessHomePageState createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  DateTime _selectedDay = DateTime.now();
  List<RequestItem> _requestList = [];

  TextEditingController _requestDetailsController = TextEditingController();

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
              SizedBox(height: 200),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'قائمة الطلبات',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Changa',
                      color: dark_color,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
                child: _requestList.isEmpty
                    ? Column(
                        children: [
                          Image.asset(
                            success_image, // Replace with the actual path
                            width: 180,
                            height: 190,
                          ),
                          Text("لا توجد طلبات لهذا اليوم")
                        ],
                      )
                    : ListView.builder(
                        itemCount: _requestList.length,
                        itemBuilder: (context, index) {
                          return RequestListItem(
                            requestItem: _requestList[index],
                          );
                        },
                      ),
              ),
              SizedBox(height: 10), //Bottom screen
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(currentPageIndex: 0 , parentContext: context),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Check if there's an accepted request passed from RequestsPage
    if (widget.acceptedRequest != null) {
      _addAcceptedRequest(widget.acceptedRequest!);
    }
  }

  void _addAcceptedRequest(Request acceptedRequest) {
    setState(() {
      _requestList.add(RequestItem(
        clientName: acceptedRequest.customerName,
        requestDetails: acceptedRequest.businessRequestDetails,
        date: acceptedRequest.dueDate,
      ));

      // Sort the list by date
      _requestList.sort((a, b) => a.date.compareTo(b.date));
    });
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
