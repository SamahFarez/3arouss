import 'package:flutter/material.dart';
import '../../../shared/images.dart';
import '../../../shared/colors.dart';
import '../home_bride.dart';
import '../categories/categories.dart';
import '../categories/publication.dart';
import '../favorites/favorite_publication.dart';
import '../../signin-bride/signin_bride.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              profile_image, // Replace with your actual image path
              fit: BoxFit.cover,
            ),
          ),
          // Your content goes here
          Positioned(
            top: 120,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'أسماء زينب',
                          style: TextStyle(
                            color: dark_color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(business_image),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'zineb.asmaa@gmail.com',
                      style: TextStyle(
                        color: dark_color,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      ' تم استخدام نص لوريم ipum الملء من قبل مصممي', // Add the description text here
                      style: TextStyle(
                        color: dark_color,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '  : الوصف',
                      style: TextStyle(
                        color: dark_color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Circular buttons at the top
          Positioned(
            top: 500,
            right: 10,
            left: 10,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle settings button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: dark_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('الإعدادات'),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrideSignInPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: dark_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('تسجيل الخروج'),
                  ),
                ),
              ],
            ),
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
                  // Handle star icon pressed action
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
                  // Handle profile icon pressed action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
