import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_business.dart';
import '../../widgets/three_buttons.dart';

enum RequestStatus {
  newRequest,
  accepted,
  refused,
}

class Request {
  final String customerName;
  final String customerWilaya;
  final String customerPhone;
  final String customerEmail;
  final String productName;
  final String productColor;
  final String productSize;
  final bool isBuying;
  RequestStatus _requestStatus;
  final DateTime dueDate;
  final String businessRequestDetails; // Additional field for business details

  Request({
    required this.customerName,
    required this.customerWilaya,
    required this.customerPhone,
    required this.customerEmail,
    required this.productName,
    required this.productColor,
    required this.productSize,
    required this.isBuying,
    required RequestStatus requestStatus,
    required this.dueDate,
    required this.businessRequestDetails,
  }) : _requestStatus = requestStatus;

  set requestStatus(RequestStatus newStatus) {
    _requestStatus = newStatus;
  }

  RequestStatus get requestStatus => _requestStatus;
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

  @override
  void initState() {
    super.initState();

    // Add three example new requests with Arabic names, Algerian phone numbers, and emails
    _requestList.add(
      Request(
        customerName: 'عبد الرحمن بن زينب',
        customerWilaya: 'الجزائر',
        customerPhone: '0555123456',
        customerEmail: 'abdelrahman@example.com',
        productName: 'المنتج أ',
        productColor: 'أحمر',
        productSize: 'كبير',
        isBuying: true,
        requestStatus: RequestStatus.newRequest,
        dueDate: DateTime.now().add(Duration(days: 7)), // Example due date
        businessRequestDetails:
            'تفاصيل طلب العميل هنا', // Example business details
      ),
    );

    _requestList.add(
      Request(
        customerName: 'فاطمة بن محمد',
        customerWilaya: 'وهران',
        customerPhone: '0777123456',
        customerEmail: 'fatima@example.com',
        productName: 'المنتج ب',
        productColor: 'أزرق',
        productSize: 'متوسط',
        isBuying: false,
        requestStatus: RequestStatus.newRequest,
        dueDate: DateTime.now().add(Duration(days: 7)), // Example due date
        businessRequestDetails:
            'تفاصيل طلب العميل هنا', // Example business details
      ),
    );

    _requestList.add(
      Request(
        customerName: 'محمد بن عبد الله',
        customerWilaya: 'البليدة',
        customerPhone: '0567123456',
        customerEmail: 'mohamed@example.com',
        productName: 'المنتج ج',
        productColor: 'أخضر',
        productSize: 'صغير',
        isBuying: true,
        requestStatus: RequestStatus.newRequest,
        dueDate: DateTime.now().add(Duration(days: 7)), // Example due date
        businessRequestDetails:
            'تفاصيل طلب العميل هنا', // Example business details
      ),
    );
    _displayedRequestList = List.from(_requestList);
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
                buttonTitles: ['جديد', 'مقبول', 'مرفوض'], // Customize button texts
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
                      style: TextStyle(color: dark_color),
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

  void _changeStatus(Request request, RequestStatus newStatus) {
    setState(() {
      request.requestStatus = newStatus;
      // Update displayed list based on the selected status
      _displayedRequestList = _filterRequestsByStatus(_selectedStatus);
    });
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
                              ? Colors.black
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
                          _changeStatus(request, RequestStatus.accepted);
                          Navigator.of(context).pop();
                        },
                      ),
                      _buildChangeStatusButton(
                        'رفض',
                        purple_color,
                        RequestStatus.refused,
                        onPressed: () {
                          _changeStatus(request, RequestStatus.refused);
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
