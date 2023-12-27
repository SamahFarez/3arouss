import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_business.dart';

class Comment {
  final String userProfileImage;
  final String userName;
  final DateTime commentDate;
  final String productName;
  final String content;

  Comment({
    required this.userProfileImage,
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
  List<Comment> _commentsList = [
    Comment(
      userProfileImage: 'path_to_image',
      userName: 'علي أحمد',
      commentDate: DateTime.now(),
      productName: 'المنتج الأول',
      content: 'هذا المنتج رائع!',
    ),
    Comment(
      userProfileImage: 'path_to_image',
      userName: 'فاطمة محمد',
      commentDate: DateTime.now().subtract(Duration(days: 1)),
      productName: 'المنتج الثاني',
      content:
          'أنا سعيدة بشرائي لهذا المنتج وأنصح الجميع بتجربته بشدة. لقد قام المنتج بتحسين حياتي بشكل كبير. شكراً للشركة المنتجة!',
    ),
    Comment(
      userProfileImage: 'path_to_image',
      userName: 'فاطمة محمد',
      commentDate: DateTime.now().subtract(Duration(days: 1)),
      productName: 'المنتج الثاني',
      content:
          'أنا سعيدة بشرائي لهذا المنتج وأنصح الجميع بتجربته بشدة. لقد قام المنتج بتحسين حياتي بشكل كبير. شكراً للشركة المنتجة!',
    ),
    Comment(
      userProfileImage: 'path_to_image',
      userName: 'محمد عبد الله',
      commentDate: DateTime.now().subtract(Duration(days: 2)),
      productName: 'المنتج الثالث',
      content:
          'تجربة رائعة مع هذا المنتج. لا يوجد لدي أي شكوى. أنا سعيد جداً بالشراء. شكرًا للفريق!',
    ),
    Comment(
      userProfileImage: 'path_to_image',
      userName: 'نورا يوسف',
      commentDate: DateTime.now().subtract(Duration(days: 3)),
      productName: 'المنتج الرابع',
      content:
          'المنتج يتفوق على توقعاتي بكثير. لقد قمت بشرائه بناءً على توصيات الأصدقاء وأنا سعيدة جدًا أنني قمت بذلك. يستحق كل قرش دفعته.',
    ),
    // Add more comments as needed
  ];

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
              Expanded(
                child: ListView.builder(
                  itemCount: _commentsList.length,
                  itemBuilder: (context, index) {
                    return _buildCommentItem(_commentsList[index]);
                  },
                ),
              ),
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
    bool isLiked = false;

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
