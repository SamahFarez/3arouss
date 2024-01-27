import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';

class PublicationPage extends StatefulWidget {
  final String imagePath;

  PublicationPage({required this.imagePath});

  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  bool isLiked = false;

  // Declare variables to hold input values
  late String date;
  late String address;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                widget.imagePath,
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                top: 40.0,
                left: 20.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // White circle background for the arrow
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    // Arrow icon to go back
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        // Navigate back to CategoryResult screen
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40.0,
                right: 30.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // White circle background for the heart
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    // Heart icon
                    IconButton(
                      icon: isLiked
                          ? Icon(Icons.favorite,
                              color: Colors.red) // Filled heart icon
                          : Icon(Icons.favorite_border),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                          // Add logic to handle adding/removing from favorites here
                          if (isLiked) {
                          } else {
                            // Remove from favorites logic
                            // ...
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    16.0, 8.0, 16.0, 16.0), // Adjust the top padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0), // Adjust the top radius
                    topRight: Radius.circular(10.0), // Adjust the top radius
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    // Username and profile picture row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side with the box and text
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'كراء',
                            style: TextStyle(color: dark_color),
                          ),
                        ),
                        // Right side with the profile picture and username
                        Row(
                          children: [
                            Text(
                              'احمد محسن',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(width: 8.0),
                            CircleAvatar(
                              backgroundImage: AssetImage(business_image),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    // Additional details or widgets
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '10.000 دج',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'برنوس لالة',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '(15 تعليقات)',
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.blue),
                            ),
                            Icon(
                              Icons.star,
                              size: 16.0,
                              color: Colors.blue,
                            ),
                            Text(
                              '4.5',
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.blue),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  ': الوصف',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'يحتوي Lorem ipsum على المحارف الأكثر استخدامًا ،',
                          style: TextStyle(fontSize: 16.0),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Add more color circles as needed
                          ],
                        ),
                        SizedBox(height: 16.0),
                        SizedBox(height: 40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _showRequestPopup(context);
                              },
                              child: Text(
                                'إرسال طلب',
                                style: TextStyle(color: dark_color),
                              ),
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  'تعليق',
                                  style: TextStyle(color: dark_color),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                    // Add more details or widgets as needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(
            currentPageIndex: 2, parentContext: context),
      ),
    );
  }

  // Function to show pop-up dialog
  void _showRequestPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إرسال طلب'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Date input
              TextField(
                onChanged: (value) => date = value,
                decoration: InputDecoration(labelText: 'التاريخ'),
              ),
              // Address input
              TextField(
                onChanged: (value) => address = value,
                decoration: InputDecoration(labelText: 'العنوان'),
              ),
              // Description input
              TextField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(labelText: 'الوصف'),
              ),
            ],
          ),
          actions: [
            // Button to send request
            ElevatedButton(
              onPressed: () {
                // Handle sending request
                _sendRequest();
                Navigator.of(context).pop();
              },
              child: Text('إرسال'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle sending request
  void _sendRequest() {
    // Implement logic to send request with input values
    print('Date: $date');
    print('Address: $address');
    print('Description: $description');
  }
}
