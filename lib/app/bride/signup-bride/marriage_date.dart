import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../home-bride/home_bride.dart';

class MarriageDateScreen extends StatefulWidget {
  @override
  _MarriageDateScreenState createState() => _MarriageDateScreenState();
}

class _MarriageDateScreenState extends State<MarriageDateScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple_color,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: dark_color),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'أنشئي حسابك وكوني عروسًا',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Changa',
                            color: dark_color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: EdgeInsets.only(right: 129.0),
                          child: Text(
                            'سجلي دخولك لتستمتعي بأفضل تجربة',
                            style: TextStyle(fontSize: 14, color: dark_color),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.66,
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
                    SizedBox(height: 16.0),
                    Center(
                      child: Image.asset(
                        married_image, // Adjust the path accordingly
                        height: 180.0, // Adjust the height as needed
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'أدخلي تاريخ حفل زفافك',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: dark_color),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80.0,
                          child: TextFormField(
                            style: TextStyle(fontSize: 16.0, color: dark_color),
                            decoration: InputDecoration(
                              labelText: 'السنة',
                              labelStyle:
                                  TextStyle(fontSize: 12.0, color: dark_color),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: purple_color, width: 2.0),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFE5EEF2), width: 1.0),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          width: 80.0,
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0, color: dark_color),
                            decoration: InputDecoration(
                              labelText: 'الشهر',
                              labelStyle:
                                  TextStyle(fontSize: 12.0, color: dark_color),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: purple_color, width: 2.0),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFE5EEF2), width: 1.0),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                          width: 80.0,
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0, color: dark_color),
                            decoration: InputDecoration(
                              labelText: 'اليوم',
                              labelStyle:
                                  TextStyle(fontSize: 12.0, color: dark_color),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: purple_color, width: 2.0),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFE5EEF2), width: 1.0),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        // You can add the logic here

                        // Navigate to BrideHmePage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrideHomePage()),
                        );
                      },
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
                            'إنشاء حساب',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Changa',
                              color: dark_color,
                            ),
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
