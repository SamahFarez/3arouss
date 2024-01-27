import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../signin-bride/signin_bride.dart';
import 'marriage_date.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



List<String> wilayasList = [
  'أدرار',
  'الشلف',
  'الأغواط',
  'أم البواقي',
  'باتنة',
  'بجاية',
  'بسكرة',
  'بشار',
  'البليدة',
  'البويرة',
  'تمنراست',
  'تبسة',
  'تلمسان',
  'تيارت',
  'تيزي وزو',
  'الجزائر',
  'الجلفة',
  'جيجل',
  'سطيف',
  'سعيدة',
  'سكيكدة',
  'سيدي بلعباس',
  'عنابة',
  'قالمة',
  'قسنطينة',
  'المدية',
  'مستغانم',
  'المسيلة',
  'معسكر',
  'ورقلة',
  'وهران',
  'البيض',
  'اليزي',
  'برج بوعريريج',
  'بومرداس',
  'الطارف',
  'تندوف',
  'تيسمسيلت',
  'الوادي',
  'خنشلة',
  'سوق أهراس',
  'تيبازة',
  'ميلة',
  'عين دفلى',
  'النعامة',
  'عين تموشنت',
  'غرداية',
  'غليزان',
];

class BrideSignUpPage extends StatefulWidget {
  @override
  _BrideSignUpPageState createState() => _BrideSignUpPageState();
}

class _BrideSignUpPageState extends State<BrideSignUpPage> {
  late PageController _pageController;
   String fullnameBride = '';
  String emailBride = '';
  String phoneNumberBride = '';
  String postalCode = '';
  String wilaya = '';
  String password = '';
  String confirm_password = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }
  Future<void> _signup() async {

     // Check if passwords match
  if (password != confirm_password) {
    print('Passwords do not match');
   
    return;
  }
    final String apiUrl = 'http://10.0.2.2:5000/bride.signup';

try {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'fullname_bride': fullnameBride,
      'email_bride': emailBride,
      'phoneNumber_bride': phoneNumberBride,
      'password': password,
      'wilaya': wilaya,
      'postal_code': postalCode,
    }),
  );

  // Handle the response based on the status code
  if (response.statusCode == 200) {
    // Signup successful
    print('Signup successful');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MarriageDateScreen()),
    );
  } else {
    // Handle errors
    print('Signup failed: ${response.statusCode}');
    // You can show an error message to the user
  }
} catch (error) {
  // Handle exceptions
  print('Error during signup: $error');
  // You can show an error message to the user
}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple_color,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: dark_color),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BrideSignInPage()),
                            );
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                        )
                      ],
                    ),
                    Text(
                      'أنشئي حسابك وكوني عروسًا',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Changa', color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.only(right: 129),
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
                height: MediaQuery.of(context).size.height * 0.7,


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
      icon: Icons.person,
      labelText: 'الإسم الكامل',
      obscureText: false,
      fontSize: 14.0,
      onChanged: (value) {
        fullnameBride = value;
      },
    ),
    RoundedInputWithIcon(
      labelText: 'الإيمايل',
      icon: Icons.email,
      obscureText: false,
      fontSize: 14.0,
      onChanged: (value) {
        emailBride = value;
      },
    ),
    RoundedInputWithIcon(
      labelText: 'رقم الهاتف',
      icon: Icons.phone,
      obscureText: false,
      fontSize: 14.0,
      onChanged: (value) {
        phoneNumberBride = value;
      },
    ),
    Row(
      children: [
        Container(
          width: 150, // Set the desired width
          child: Expanded(
            child: RoundedTextFieldWithIcon(
                  labelText: 'الرمز البريدي',
                  icon: Icons.markunread_mailbox,
                  hintText: 'أدخل الرمز البريدي',
                  keyboardType: TextInputType.number,
                  fontSize: 14.0,
                  onChanged: (value) {
                  postalCode = value;
                  },
             ),
          ),
        ),
        SizedBox(width: 5.0),
        Expanded(
          child: RoundedDropdownWithIcon(
          labelText: 'الولاية',
          icon: Icons.location_city,
          wilayas: wilayasList,
          fontSize: 14.0,
          onChanged: (value) {
          wilaya = value ?? ''; // Ensure that wilaya is not null
          },
          ),

        ),
      ],
    ),
    RoundedInputWithIcon(
      labelText: 'كلمة السر',
      icon: Icons.lock,
      obscureText: true,
      fontSize: 14.0,
      onChanged: (value) {
        password = value;
      },
    ),
                    RoundedInputWithIcon(
                      labelText: 'تأكيد كلمة السر',
                      icon: Icons.lock,
                      obscureText: true,
                      fontSize: 14.0,
                       onChanged: (value) {
                      confirm_password = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed:  _signup,
                     
                      style: ElevatedButton.styleFrom(
                        primary: purple_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'التالي',
                            style: TextStyle(fontSize: 14.0, fontFamily: 'Changa', color: Colors.black),
                          ),
                        ),
                      ),
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
  final ValueChanged<String> onChanged; // Callback for text changes

  RoundedInputWithIcon({
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.fontSize = 14.0,
    required this.onChanged, // Added onChanged parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          suffixIcon: Icon(icon, color: blue_color),
          labelText: labelText,
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
        onChanged: onChanged, // Trigger the callback on text changes
      ),
    );
  }
}


class RoundedTextFieldWithIcon extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final double fontSize;
  final ValueChanged<String> onChanged; // Callback for text changes

  RoundedTextFieldWithIcon({
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    this.fontSize = 14.0,
    required this.onChanged, // Added onChanged parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          suffixIcon: Icon(icon, color: blue_color),
          labelText: labelText,
          hintText: hintText,
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
        keyboardType: keyboardType,
        style: TextStyle(fontSize: fontSize, color: Colors.black),
        onChanged: onChanged, // Trigger the callback on text changes
      ),
    );
  }
}
class RoundedDropdownWithIcon extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final List<String> wilayas;
  final double fontSize;
  final ValueChanged<String?> onChanged; // Callback for dropdown changes

  RoundedDropdownWithIcon({
    required this.labelText,
    required this.icon,
    required this.wilayas,
    this.fontSize = 14.0,
    required this.onChanged, // Added onChanged parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
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
          labelStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Changa',
          ),
        ),
        items: wilayas.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: fontSize,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
          fontFamily: 'Changa',
        ),
      ),
    );
  }
}