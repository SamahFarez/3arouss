import 'package:flutter/material.dart';
import 'welcome.dart';
import 'images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7), // Adjust the duration as needed
    );

    // Create fade-in animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 9.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when the widget is mounted
    _animationController.forward();

    // Delay for 3 seconds before navigating to the welcome page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AccountType(), // Replace with your WelcomePage
        ),
      );
    });
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            splash_screen, // Update with your image path
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),

          // Content on top of the background with fade-in animation
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    logo_image, // Update with your image path
                    height: 150, // Adjust the size as needed
                    width: 150,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
