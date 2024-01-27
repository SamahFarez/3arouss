import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_business.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

final Dio dio = Dio();

Future<List<Map<String, dynamic>>> getCommentsData() async {
  print("getting data....");

  String endpoint =
      'https://3arouss-app-flask.vercel.app/retrieve_comments.get';

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
          print("Comments data: ${dataList}");
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

class Comment {
  final String userName;
  final DateTime commentDate;
  final String productName;
  final String content;

  Comment({
    required this.userName,
    required this.commentDate,
    required this.productName,
    required this.content,
  });
}

class CommentsListPage extends StatefulWidget {
  @override
  _CommentsListPageState createState() => _CommentsListPageState();
}

class _CommentsListPageState extends State<CommentsListPage> {
  List<Comment> _commentsList = [];

  Future<List<Comment>> populateComments() async {
    List<Map<String, dynamic>>? requestData = await getCommentsData();
    List<Comment> comments = [];

    if (requestData != null && requestData.isNotEmpty) {
      for (var data in requestData) {
        List<Map<String, dynamic>> publicationData =
            await getPublicationData(data['publication_id']);
        List<Map<String, dynamic>> brideData =
            await getBrideData(data["bride_id"]);

        comments.add(
          Comment(
            userName: brideData[0]['fullname_bride'] ?? 'N/A',
            commentDate: DateTime.parse(
                data['comment_date'] ?? DateTime.now().toString()),
            productName: publicationData[0]['publication_name'] ?? 'N/A',
            content: data['comment_content'] ?? '',
          ),
        );
      }
    } else {
      print('Error: Request data is null or empty');
    }

    return comments;
  }

  @override
  void initState() {
    super.initState();
    populateComments();
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
              SizedBox(height: 190),
              // You can customize the header as needed
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'قائمة التعليقات',
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              FutureBuilder<List<Comment>>(
                future:
                    populateComments(), // Call the function to fetch comment data
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while data is being fetched
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Show an error message if data fetching fails
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Once data is fetched successfully, build the ListView
                    List<Comment>? comments = snapshot.data;
                    if (comments != null && comments.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return _buildCommentItem(comments[index]);
                          },
                        ),
                      );
                    } else {
                      // Show a message if there are no comments
                      return Text('No comments available.');
                    }
                  }
                },
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(
            currentPageIndex: 3, parentContext: context),
      ),
    );
  }

  Widget _buildCommentItem(Comment comment) {
    // Specify the maximum number of lines to display in the main list
    final int maxLinesInList = 1;

    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        trailing: ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            bride_image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(comment.commentDate),
                  style: TextStyle(color: dark_purple_color),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  comment.userName,
                  style: TextStyle(color: dark_color),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              'المنتج: ${comment.productName}',
              style: TextStyle(fontSize: 14),
              textDirection: TextDirection.rtl,
            ),
            // Show a maximum of two lines in the main list
            Text(
              comment.content,
              maxLines: maxLinesInList,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: text_gray_color),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 8),
          ],
        ),
        onTap: () => _showCommentDetails(comment),
      ),
    );
  }

  void _showCommentDetails(Comment comment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تفاصيل التعليق',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Container(
              height: 200, // Set the height to 300
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'التاريخ: ${_formatDate(comment.commentDate)}',
                    style: TextStyle(color: dark_purple_color),
                  ),
                  Text(
                    'المنتج: ${comment.productName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'التعليق: ${comment.content}',
                    style: TextStyle(fontSize: 14, color: text_gray_color),
                  ),
                ],
              ),
            ),
            actions: [
              Center(
                child: Container(
                  width: 150, // Set the width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: purple_color,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'إغلاق',
                      style: TextStyle(color: white_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
