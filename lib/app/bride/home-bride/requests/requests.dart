import 'package:flutter/material.dart';
import '../../../shared/images.dart';
import '../../../shared/colors.dart';
import '../home_bride.dart';
import '../categories/categories.dart';
import '../favorites/favorite_publication.dart';
import '../profile/profile_bride.dart';

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

class RequestsScreen extends StatefulWidget {
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsScreen> {
  List<Request> _requestList = [];
  List<Request> _displayedRequestList = [];
  RequestStatus _selectedStatus = RequestStatus.newRequest; // Add this line

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void initState() {
    super.initState();
    _displayedRequestList = List.from(_requestList);

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
              SizedBox(height: 180),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatusButton(
                      'تم رفضه',
                      RequestStatus.refused,
                    ),
                    _buildStatusButton(
                      'تم قبوله',
                      RequestStatus.accepted,
                    ),
                    _buildStatusButton(
                      'في الانتظار ',
                      RequestStatus.newRequest,
                    ),
                  ],
                ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrideHomePage()),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(categories_outlined_icon)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(star_outlined_icon)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequestsScreen()),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(heart_outlined_icon)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoritePublicationScreen()),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(profile_outlined_icon)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
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
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(white_color),
          fixedSize: MaterialStateProperty.all(
            Size(double.infinity, 100),
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
              // Product Name
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
    });
  }
}
