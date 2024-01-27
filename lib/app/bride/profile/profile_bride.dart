import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../signin-bride/signin_bride.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';

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
            top: 250,
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
                        SizedBox(height: 5),
                        Text(
                          'kiki@gmail.com',
                          style: TextStyle(
                            color: dark_color,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
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
          // Circular buttons at the top
          Positioned(
            top: 600,
            right: 10,
            left: 10,
            child: Column(
              children: [
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
        child: CustomBottomNavigationBar(
            currentPageIndex: 4, parentContext: context),
      ),
    );
  }
}
