import 'package:flutter/material.dart';
import 'app/bride/signup-bride/signup_bride.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BrideSignUpPage(), // Specify the page you want to run
    );
  }
}
