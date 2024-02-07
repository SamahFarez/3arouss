import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';

class PublicationPage extends StatefulWidget {
  final String imagePath;
  final String publicationName;
  final int publicationPrice;
  final int publicationId;
  final int publicationtype;
  final String publicationcontent;

  PublicationPage({
    required this.imagePath,
    required this.publicationName,
    required this.publicationPrice,
    required this.publicationId,
    required this.publicationtype,
    required this.publicationcontent,
  });

  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  bool isLiked = false;

  // Declare variables to hold input values
  late String date;
  late String address;
  late String description;
  late String commentContent;

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
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
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
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                   IconButton(
                        icon: isLiked
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border),
                        onPressed: () {
                          _toggleLike();
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
                padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            widget.publicationtype == 1 ? 'كراء' : 'بيع',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'احمد محسن',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(width: 8.0),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/business_image.jpg'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.publicationPrice.toString()} دج',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.publicationName,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '(15 تعليقات)',
                              style: TextStyle(fontSize: 16.0, color: Colors.blue),
                            ),
                            Icon(
                              Icons.star,
                              size: 16.0,
                              color: Colors.blue,
                            ),
                            Text(
                              '4.5',
                              style: TextStyle(fontSize: 16.0, color: Colors.blue),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          widget.publicationcontent,
                          style: TextStyle(fontSize: 16.0),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [],
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
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _showCommentPopup(context);
                              },
                              child: Text(
                                'تعليق',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

void _toggleLike() async {
  try {
    int brideId = 7; // Replace with your logic to get the bride_id
    int publicationId = widget.publicationId;

    String endpoint;

    if (isLiked) {
      endpoint = 'https://3arouss-app-flask.vercel.app/api/add-like';
    } else {
      endpoint = 'https://3arouss-app-flask.vercel.app/api/delete-like';
    }

    final response = await http.post(
      Uri.parse('$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'bride_id': brideId,
        'publication_id': publicationId,
      }),
    );

    print('Server Response: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      setState(() {
        isLiked = !isLiked;
      });

      if (isLiked) {
        print('Publication removed from favoritepub successfully');
      } else {
        print('Publication added to favoritepub successfully');
      }

      print('Like status toggled successfully');
    } else {
      print('Error toggling like: ${response.statusCode}');
    }
  } catch (e) {
    print('Error toggling like: $e');
  }
}

  void _submitComment() async {
    try {
      int brideId = 7; // Replace with your logic to get the bride_id
      int publicationId = widget.publicationId;
      String content = commentContent ?? '';

      String apiUrl = 'https://3arouss-app-flask.vercel.app/add-comment';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'bride_id': brideId,
          'publication_id': publicationId,
          'comment_content': content,
        }),
      );
       
       final supabase_response = jsonDecode(response.body);
       
      if (supabase_response['message'] =='Comment added successfully') {
        print('Comment added successfully');
      } else {
        print('Error adding comment: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting comment: $e');
    }
  }

  void _showCommentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إضافة تعليق'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Comment content input
              TextField(
                onChanged: (value) {
                  setState(() {
                    commentContent = value;
                  });
                },
                decoration: InputDecoration(labelText: 'التعليق'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _submitComment();
                Navigator.of(context).pop();
              },
              child: Text('إرسال'),
            ),
          ],
        );
      },
    );
  }

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
                onChanged: (value) {
                  setState(() {
                    date = value;
                  });
                },
                decoration: InputDecoration(labelText: 'التاريخ'),
              ),
              // Address input
              TextField(
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
                decoration: InputDecoration(labelText: 'العنوان'),
              ),
              // Description input
              TextField(
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                decoration: InputDecoration(labelText: 'الكمية'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
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

  void _sendRequest() async {
    int brideId = 7; // Replace with your logic to get the bride_id
    int publicationId = widget.publicationId;
    String date = this.date ?? '';
    String address = this.address ?? '';
    String description = this.description ?? '';

    try {
      String apiUrl = 'https://3arouss-app-flask.vercel.app/bride.request';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'request_due_date': date,
          'request_address': address,
          'bride_id': brideId,
          'publication_id': publicationId,
          'quantity': 1, // Assuming a default quantity
        }),
      );

      if (response.statusCode == 200) {
        print('Request submitted successfully');
      } else {
        print('Error submitting the request');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }
}