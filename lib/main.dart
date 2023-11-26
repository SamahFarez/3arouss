import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/bride/home-bride/home_bride.dart'; 


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List with Calendar',
      theme: ThemeData(
        primaryColor: Color(0xFFD8C2FF),
        fontFamily: 'Changa', // Set the default font family to Changa
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('ar', 'SA'), // Arabic
      ],
      home: BrideHomePage(),
    );
  }
}
