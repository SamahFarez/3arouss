import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../requests_business/requests_page.dart';
import '../../widgets/bottom_navigation_bar_business.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio();

Future<List<Map<String, dynamic>>> getAcceptedRequestsData() async {
  print("getting data....");

  String endpoint =
      'https://3arouss-app-flask.vercel.app/retrieve_accepted_requests.get';

  print("Endpoint: $endpoint");

  try {
    var response = await dio.get(endpoint);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> dataList = [];

      // Check if the response is a Map
      if (response.data is Map<String, dynamic>) {
        Map<String, dynamic> jsonData = response.data;

        // Check if the 'data' key exists and is a list
        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          dataList = List<Map<String, dynamic>>.from(jsonData['data']);
          print("Requests data: ${dataList}");
        } else {
          print("Error: 'data' key not found or not a list");
        }
      } else {
        print("Error: Response is not a Map");
      }

      return dataList;
    } else {
      // Handle HTTP error
      print("Error: ${response.statusCode}");
    }
  } catch (error) {
    // Handle other errors
    print("Error: $error");
  }

  return [];
}

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
          width: 1,
          color: text_gray_color,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
     child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:Column(
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
                  SizedBox(width: 10), // Adjust spacing between name and details
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
                  Text(
                    requestItem.requestDetails,
                    style: TextStyle(
                      color: dark_purple_color,
                      fontSize: 12,
                      fontFamily: 'Changa',
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

  // Populate requests and sort by due date
  Future<void> populateRequests() async {
    List<Map<String, dynamic>>? requestData = await getRequestsData();

    if (requestData != null && requestData.isNotEmpty) {
      for (var data in requestData) {
        List<Map<String, dynamic>> publicationData =
            await getPublicationData(data['publication_id']);
        List<Map<String, dynamic>> brideData =
            await getBrideData(data["bride_id"]);

        _requestList.add(
          RequestItem(
            clientName: brideData[0]['fullname_bride'] ?? 'N/A',
            requestDetails: publicationData[0]['publication_name'] ?? 'N/A',
            date: DateTime.parse(
                data['request_due_date'] ?? DateTime.now().toString()),
          ),
        );
      }

      // Sort by due date
      _requestList.sort((a, b) => a.date.compareTo(b.date));
    } else {
      print('Error: Request data is null or empty');
    }
  }

  @override
  void initState() {
    super.initState();
    populateRequests();

    // Check if there's an accepted request passed from RequestsPage
    if (widget.acceptedRequest != null) {
      _addAcceptedRequest(widget.acceptedRequest!);
    }
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
        child: CustomBottomNavigationBar(
            currentPageIndex: 0, parentContext: context),
      ),
    );
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
