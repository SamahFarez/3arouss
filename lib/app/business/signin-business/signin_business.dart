import 'package:flutter/material.dart';
import '../signup-business/signup_business.dart'; // Make sure to import the correct file
import '../../shared/images.dart';
import '../../shared/colors.dart';


class BusinessSignInPage extends StatefulWidget {
  @override
  _BusinessSignInPageState createState() => _BusinessSignInPageState();
}

class _BusinessSignInPageState extends State<BusinessSignInPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue_color,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.transparent,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'مرحبا بعودتك',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Changa', color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.only(right: 48.0),
                      child: Text(
                        'سجلي دخولك لتستمتعي بأفضل تجربة',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedInputWithIcon(
                      labelText: 'الإيمايل',
                      icon: Icons.email,
                      obscureText: false,
                      fontSize: 14.0,
                    ),
                    RoundedInputWithIcon(
                      labelText: 'كلمة السر',
                      icon: Icons.lock,
                      obscureText: true,
                      fontSize: 14.0,
                      
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: false, // Handle the state
                              onChanged: (value) {
                                // Handle checkbox state change
                              },
                            ),
                            Text('تذكرني', style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle Forget Password
                          },
                          child: Text('هل نسيت كلمة السر؟', style: TextStyle(fontSize: 14.0, color: Colors.blue)),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle sign-in logic here without navigation
                        // For example, validate inputs and perform sign-in actions
                        // Once signed in, you can navigate to the next screen if needed.
                      },
                      style: ElevatedButton.styleFrom(
                        primary: blue_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(fontSize: 14.0, fontFamily: 'Changa', color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ليس لديك حساب؟', style: TextStyle(fontSize: 14.0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => businessSignUpPage()),
                            );
                          },
                          child: Text('سجلي الآن', style: TextStyle(fontSize: 14.0, color: Colors.blue)),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.0), // Added space here
                    Text(
                      '---------  : أو سجل بإستعمال ---------',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0), // Added space here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialLoginButton(
                          text: 'Apple',
                          onPressed: () {
                            // Handle Apple login
                          },
                        ),
                        SizedBox(width: 16.0),
                        SocialLoginButton(
                          text: 'Google',
                          onPressed: () {
                            // Handle Google login
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class RoundedInputWithIcon extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final double fontSize;

  RoundedInputWithIcon({
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: Icon(icon, color: blue_color),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Color(0xFFE5EEF2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Color(0xFFE5EEF2)),
          ),
          labelStyle: TextStyle(color: Colors.black),
        ),
        obscureText: obscureText,
        style: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  SocialLoginButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0, color: Colors.black),
      ),
    );
  }
}
