import 'package:flutter/material.dart';
import '../bride/signin-bride/signin_bride.dart';
import '../business/signin-business/signin_business.dart';
import 'images.dart';


class AccountType extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            Splash2_image,  // Update with your image path
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),

          // Content on top of the background
          Column(
            mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BrideSignInPage(),
                        ),
                      );
                    },
                    child: Image.asset(
                      bride_icon,
                      height: 100,
                      width: 100,
                    ),
                  ),

                  // Add more space between the buttons
                  SizedBox(width: 70),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusinessSignInPage(),
                        ),
                      );
                    },
                    child: Image.asset(
                      business_icon,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
              ),
                                SizedBox(height: 60),


            ],
          ),
        ],
      ),
    );
  }
}
