import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../home-bride/home_bride.dart';
import 'dart:convert';

class MarriageDateScreen extends StatefulWidget {
  final String emailBride;

  MarriageDateScreen(this.emailBride);

  @override
  _MarriageDateScreenState createState() => _MarriageDateScreenState();
}

class _MarriageDateScreenState extends State<MarriageDateScreen> {
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
  }

Future<void> _submitForm() async {
  try {
    // Validate that the dateController is not empty
    if (dateController.text.isEmpty) {
      print('Please enter a valid date.');
      return;
    }

    String apiUrl =
        'https://3arouss-app-flask.vercel.app/bride_marriagedate.get/${widget.emailBride}';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'date': dateController.text,
      }),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BrideHomePage()),
        );
      // Handle success
    } else {
      print('Failed to send data. Status code: ${response.statusCode}');
      // Handle failure
    }
  } catch (e) {
    print('Error sending data: $e');
    // Handle error
  }
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
                        married_image,
                        height: 180.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'أدخلي تاريخ حفل زفافك',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dark_color,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFE5EEF2),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'تاريخ الزفاف:',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: dark_color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              width: 120.0,
                              child: TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  hintText: 'YYYY-MM-DD',
                                ),
                                keyboardType: TextInputType.datetime,
                                onChanged: (value) {
                                  // You can add validation or additional logic here
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _submitForm,
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
    dateController.dispose();
    super.dispose();
  }
}
