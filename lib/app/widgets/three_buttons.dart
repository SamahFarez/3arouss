import 'package:flutter/material.dart';

class ThreeButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BigButton(
            image: AssetImage('assets/button1.png'), // Replace with your image path
            text: 'Button 1',
          ),
          BigButton(
            image: AssetImage('assets/button2.png'), // Replace with your image path
            text: 'Button 2',
          ),
          BigButton(
            image: AssetImage('assets/button3.png'), // Replace with your image path
            text: 'Button 3',
          ),
        ],
      ),
    );
  }
}

class BigButton extends StatelessWidget {
  final ImageProvider<Object> image;
  final String text;

  BigButton({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add your onTap logic here
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue, // You can customize the background color
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Three Button Row Example'),
      ),
      body: ThreeButtonRow(),
    ),
  ));
}
