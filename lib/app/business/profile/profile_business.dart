import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_business.dart';
import 'publication.dart';

class BusinessProfileScreen extends StatelessWidget {
  final List<String> categoryButtons = [
    'ملابس',
    'أحذية',
    'مجوهرات',
    'ديكور',
    'قاعات حفلات',
    'مصففات الشعر',
    'حلويات',
    'فوتوغرافر',
    // Add more categories as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              background_image, // Replace with your actual image path
              fit: BoxFit.cover,
            ),
          ),
          // User Profile Information
          Positioned(
            top: 220,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Alger', // Add the user's phone number
                              style: TextStyle(
                                color: text_gray_color,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 150),
                            Text(
                              'أسماء زينب',
                              style: TextStyle(
                                color: dark_color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '  Email:', // Add the user's phone number
                              style: TextStyle(
                                color: dark_color,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 67),
                            Text(
                              'zineb.zineb@gmail.com', // Add the user's phone number
                              style: TextStyle(
                                color: dark_color,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Phone:', // Add the user's phone number
                              style: TextStyle(
                                color: dark_color,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 140),
                            Text(
                              '0566889944', // Add the user's phone number
                              style: TextStyle(
                                color: dark_color,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(business_image),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          // Swiper and Grid of Products
          // Row of Category Buttons
          // Row of Category Buttons
          Positioned(
            top: 320,
            right: 0,
            left: 0,
            bottom: 20, // Adjust the bottom padding as needed
            child: Column(
              children: [
                // Grid of Products
                Expanded(
                  child: Container(
                    height: 450,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the PublicationPage with the selected card's image
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PublicationPage(imagePath: dress_image),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  dress_image,
                                  fit: BoxFit.cover,
                                ),
                                Positioned.fill(
                                  child: Transform.scale(
                                    scale:
                                        1.1, // Adjust the scale factor as needed
                                    child: Image.asset(
                                      product_decoration_image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 6.0,
                                  left: 15.0, // Adjust left padding
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'برنوس ',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: dark_color,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '25000 دج',
                                        style: TextStyle(
                                          fontSize: 9.0,
                                          fontWeight: FontWeight.bold,
                                          color: dark_blue_color,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(
          currentPageIndex: 4,
          parentContext: context,
        ),
      ),
    );
  }
}
