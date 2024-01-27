import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_business.dart';
import '../../widgets/three_buttons.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

final Dio dio = Dio();

Future<List<Map<String, dynamic>>> getRequestsData() async {
  print("getting data....");

  String endpoint =
      'https://3arouss-app-flask.vercel.app/retrieve_requests.get';

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

Future<List<Map<String, dynamic>>> getPublicationData(
    int publication_id) async {
  print("getting data....");

  String endpoint =
      'https://3arouss-app-flask.vercel.app/retrieve_publication_using_id/${publication_id.toString()}';

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
          print("Publication data: ${dataList}");
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

Future<List<Map<String, dynamic>>> getBrideData(int bride_id) async {
  print("getting data....");

  String endpoint =
      'https://3arouss-app-flask.vercel.app/retrieve_bride_using_id/${bride_id}';

  print("Endpoint: $endpoint");

  try {
    var response = await dio.get(endpoint);

    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      List<Map<String, dynamic>> dataList = [];

      // Check if the response is a Map
      if (response.data is Map<String, dynamic>) {
        Map<String, dynamic> jsonData = response.data;

        // Check if the 'data' key exists and is a list
        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          dataList = List<Map<String, dynamic>>.from(jsonData['data']);
          print(dataList);
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

Future<List<Map<String, dynamic>>> getAddressData(int address_id) async {
  print("getting data....");

  String endpoint =
      'https://3arouss-app-flask.vercel.app/retrieve_address_using_id/${address_id}';

  print("Endpoint: $endpoint");

  try {
    var response = await dio.get(endpoint);

    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      List<Map<String, dynamic>> dataList = [];

      // Check if the response is a Map
      if (response.data is Map<String, dynamic>) {
        Map<String, dynamic> jsonData = response.data;

        // Check if the 'data' key exists and is a list
        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          dataList = List<Map<String, dynamic>>.from(jsonData['data']);
          print(dataList);
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

Future<String> getRequestStateName(int requestId) async {
  print("getting request state name....");

  String endpoint =
      'https://3arouss-app-flask.vercel.app/retrieve_request_state_using_id/$requestId';

  print("Endpoint: $endpoint");

  try {
    var response = await dio.get(endpoint);

    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(jsonDecode(response.data));

      if (responseData.isNotEmpty) {
        // Use the first entry in the list
        Map<String, dynamic> firstEntry = responseData;
        String stateName = firstEntry['state_name'];
        return stateName;
      } else {
        print("Error: Empty response data");
      }
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (error) {
    print("Error: $error");
  }

  return ""; // or throw an exception indicating an error
}

enum RequestStatus {
  newRequest,
  accepted,
  refused,
}

class Request {
  final int requestId;
  final String customerName;
  final String customerWilaya;
  final String customerPhone;
  final String customerEmail;
  final String productName;
  final String productColor;
  final String productSize;
  final bool isBuying;
  final RequestStatus requestStatus; // Updated type
  final DateTime dueDate;
  final String businessRequestDetails;

  Request({
    required this.requestId,
    required this.customerName,
    required this.customerWilaya,
    required this.customerPhone,
    required this.customerEmail,
    required this.productName,
    required this.productColor,
    required this.productSize,
    required this.isBuying,
    required this.requestStatus, // Updated parameter
    required this.dueDate,
    required this.businessRequestDetails,
  });
}

class RequestsPage extends StatefulWidget {
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  List<Request> _requestList = [];
  List<Request> _displayedRequestList = [];
  RequestStatus _selectedStatus = RequestStatus.newRequest; // Add this line

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> populateRequests() async {
    List<Map<String, dynamic>>? requestData = await getRequestsData();

    if (requestData != null && requestData.isNotEmpty) {
      List<Map<String, dynamic>> dataList = requestData;
      for (var data in dataList) {
        List<Map<String, dynamic>> publicationData =
            await getPublicationData(data['publication_id']);
        List<Map<String, dynamic>> brideData =
            await getBrideData(data["bride_id"]);

        _requestList.add(
          Request(
            requestId: data['request_id'] ?? 'N/A',
            customerName: brideData[0]['fullname_bride'] ?? 'N/A',
            customerWilaya: data['request_address'] ?? 'N/A',
            customerPhone: brideData[0]['phonenumber_bride'] ?? 'N/A',
            customerEmail: brideData[0]['email_bride'] ?? 'N/A',
            productName: publicationData.isNotEmpty
                ? publicationData[0]['publication_name'] ?? 'N/A'
                : 'N/A',
            productColor: data['productColor'] ?? 'N/A',
            productSize: data['productSize'] ?? 'N/A',
            isBuying: data['isBuying'] ?? false,
            requestStatus: _getRequestStatus(data['request_state']), // Updated
            dueDate: DateTime.parse(
                data['request_due_date'] ?? DateTime.now().toString()),
            businessRequestDetails: data['businessRequestDetails'] ?? '',
          ),
        );
      }
    } else {
      print('Error: Request data is null or empty');
    }

    _displayedRequestList = List.from(_requestList);
  }

  RequestStatus _getRequestStatus(int status) {
    switch (status) {
      case 0:
        return RequestStatus.newRequest;
      case 1:
        return RequestStatus.accepted;
      case 2:
        return RequestStatus.refused;
      default:
        throw ArgumentError('Invalid status: $status');
    }
  }

  @override
  void initState() {
    super.initState();
    populateRequests();
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
              ToggleButtonsWidget(
                buttonTitles: [
                  'جديد',
                  'مقبول',
                  'مرفوض'
                ], // Customize button texts
                selectedIndex: _selectedStatus.index,
                onButtonTapped: (index) {
                  setState(() {
                    _selectedStatus = _getStatusFromIndex(index);
                    _displayedRequestList =
                        _filterRequestsByStatus(_selectedStatus);
                  });
                },
              ),
              Expanded(
                child: _displayedRequestList.isEmpty
                    ? Center(
                        child: Text(
                          'لا يوجد طلبات.',
                          style: TextStyle(color: white_color),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _displayedRequestList.length,
                        itemBuilder: (context, index) {
                          return _buildRequestItem(
                              _displayedRequestList[index]);
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(
            currentPageIndex: 1, parentContext: context),
      ),
    );
  }

  RequestStatus _getStatusFromIndex(int index) {
    switch (index) {
      case 0:
        return RequestStatus.newRequest;
      case 1:
        return RequestStatus.accepted;
      case 2:
        return RequestStatus.refused;
      default:
        throw ArgumentError('Invalid index: $index');
    }
  }

  Widget _buildStatusButton(String title, RequestStatus status) {
    Color backgroundColor = _getButtonBackgroundColor(status);
    bool isSelected = _selectedStatus == status;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          _displayedRequestList = _filterRequestsByStatus(status);
          _selectedStatus = status;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return gray_color; // Use the provided color when pressed
            }
            return isSelected ? gray_color : backgroundColor;
          },
        ),
        fixedSize: MaterialStateProperty.all(
          Size(110, 30),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: isSelected ? text_gray_color : text_gray_color),
      ),
    );
  }

  Color _getButtonBackgroundColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.newRequest:
        return white_color;
      case RequestStatus.accepted:
        return white_color;
      case RequestStatus.refused:
        return white_color;
    }
  }

  List<Request> _filterRequestsByStatus(RequestStatus status) {
    return _requestList
        .where((request) => request.requestStatus == status)
        .toList();
  }

  Widget _buildRequestItem(Request request) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          _showChangeStatusDialog(context, request);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(white_color),
          side: MaterialStateProperty.all(
            BorderSide(
              color: gray_color,
              width: 1.0,
            ),
          ),
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
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.productName,
                      style: TextStyle(color: dark_purple_color),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              // User Name
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      request.customerName,
                      style: TextStyle(color: dark_color),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeStatusButton(
      String title, Color color, RequestStatus status,
      {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        fixedSize: MaterialStateProperty.all(
          Size(110, 30),
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

  void _changeStatus(Request request, int newStatus) async {
    // Prepare the request data
    Map<String, dynamic> requestData = {
      'request_id': request.requestId.toString(), // Convert requestId to String
      'new_status': newStatus,
    };

    // Send the PUT request to update the status
    try {
      var response = await dio.put(
        'https://3arouss-app-flask.vercel.app/update_request_status',
        data: requestData,
      );

      if (response.statusCode == 200) {
        // Update the status locally if the request was successful
        setState(() {
          // Update displayed list based on the selected status
          _displayedRequestList = _filterRequestsByStatus(_selectedStatus);
        });
      } else {
        print(
            'Failed to update status. Server responded with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating status: $error');
    }
  }

  void _showChangeStatusDialog(BuildContext context, Request request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Replace CircleAvatar with Image
                  Image.asset(
                    bride_image,
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 15),
                  Text(
                    request.customerName,
                    style: TextStyle(
                      color: dark_color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            content: Container(
              height: 350,
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'البريد الإلكتروني: ${request.customerEmail}',
                    style: TextStyle(color: dark_color),
                  ),
                  Text(
                    'رقم الهاتف: ${request.customerPhone}',
                    style: TextStyle(color: dark_color),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'اسم المنتج: ${request.productName}',
                    style: TextStyle(color: dark_color),
                  ),
                  Row(
                    children: [
                      Text(
                        'اللون:',
                        style: TextStyle(color: dark_color),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: request.productColor.toLowerCase() == 'black'
                              ? dark_color
                              : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'الحجم: ${request.productSize}',
                    style: TextStyle(color: dark_color),
                  ),
                  Text(
                    'النوع: ${request.isBuying ? 'شراء' : 'إيجار'}',
                    style: TextStyle(color: dark_color),
                  ),
                  Text(
                    'تاريخ الاستحقاق: ${_formatDate(request.dueDate)}',
                    style: TextStyle(color: dark_color),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildChangeStatusButton(
                        'تأكيد',
                        blue_color,
                        RequestStatus.accepted,
                        onPressed: () {
                          _changeStatus(request, 1);
                          Navigator.of(context).pop();
                        },
                      ),
                      _buildChangeStatusButton(
                        'رفض',
                        purple_color,
                        RequestStatus.refused,
                        onPressed: () {
                          _changeStatus(request, 2);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
