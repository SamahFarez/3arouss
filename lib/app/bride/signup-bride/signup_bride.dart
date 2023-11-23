import 'package:flutter/material.dart';

class BrideSignUpPage extends StatefulWidget {
  @override
  _BrideSignUpPageState createState() => _BrideSignUpPageState();
}

class _BrideSignUpPageState extends State<BrideSignUpPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            color: Color(0xFFD8C2FF),
            child: Center(
              child: Text(
                'أنشئي حسابك وكوني عروسًا.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'HSIshraq Light', color: Colors.black),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                buildSignUpSection(),
                buildSignInSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignUpSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Form elements for sign up
          RoundedInputWithIcon(
            labelText: 'الإسم الكامل',
            icon: Icons.person,
            obscureText: false,
            fontSize: 14.0,
          ),
          RoundedInputWithIcon(
            labelText: 'الإيمايل',
            icon: Icons.email,
            obscureText: false,
            fontSize: 14.0,
          ),
          RoundedInputWithIcon(
            labelText: 'رقم الهاتف',
            icon: Icons.phone,
            obscureText: false,
            fontSize: 14.0,
          ),
          Row(
            children: [
              Expanded(
                child: RoundedDropdownWithIcon(
                  labelText: 'الولاية',
                  icon: Icons.location_city,
                  items: ['Option 1', 'Option 2'],
                  fontSize: 14.0,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: RoundedDropdownWithIcon(
                  labelText: 'الرمز البريدي',
                  icon: Icons.markunread_mailbox,
                  items: ['Option A', 'Option B'],
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          RoundedInputWithIcon(
            labelText: 'كلمة السر',
            icon: Icons.lock,
            obscureText: true,
            fontSize: 14.0,
          ),
          RoundedInputWithIcon(
            labelText: 'تأكيد كلمة السر',
            icon: Icons.lock,
            obscureText: true,
            fontSize: 14.0,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle sign-up button press
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFD8C2FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: Container(
              width: double.infinity,
              child: Center(
                child: Text(
                  'التالي',
                  style: TextStyle(fontSize: 14.0, fontFamily: 'HSIshraq Light', color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Form elements for sign in
          RoundedInputWithIcon(
            labelText: 'اسم المستخدم',
            icon: Icons.person,
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
          ElevatedButton(
            onPressed: () {
              // Handle sign-in button press
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFD8C2FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: Container(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 14.0, fontFamily: 'HSIshraq Light', color: Colors.black),
                ),
              ),
            ),
          ),
        ],
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
          prefixIcon: Icon(icon, color: Color(0xFFD8C2FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        textAlign: TextAlign.right,
        obscureText: obscureText,
        style: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
    );
  }
}

class RoundedDropdownWithIcon extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final List<String> items;
  final double fontSize;

  RoundedDropdownWithIcon({
    required this.labelText,
    required this.icon,
    required this.items,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Color(0xFFD8C2FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          // Handle dropdown value change
        },
        style: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
    );
  }
}
