import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_business.dart';
import '../../widgets/three_buttons.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    MaterialApp(
      home: AddProductPage(),
    ),
  );
}

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<Color> _selectedColors = [];
  List<TextEditingController> _sizeControllers = [TextEditingController()];

  bool _isSellSelected = true; // Track if "Sell" button is selected
  bool _isRentSelected = false; // Track if "Rent" button is selected

  String _selectedImagePath = ''; // To store the path of the selected image
  String _selectedProductType = 'Clothes'; // Default type, you can change this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 50),
                Container(
                  width: 350,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "إضافة منتج",
                    style: TextStyle(fontSize: 20, color: dark_color),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),

                // Product Type Dropdown
                DropdownButton<String>(
                  value: _selectedProductType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedProductType = newValue!;
                    });
                  },
                  items: <String>[
                    'Clothes',
                    'Hair Styling',
                    'Shoes',
                    'Sweets',
                    'Party Rooms',
                    // Add other product types as needed
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectImage();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 5),
                        width: 250,
                        height: 200,
                        decoration: BoxDecoration(
                          color: white_color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _selectedImagePath != ''
                            ? Image.file(
                                File(_selectedImagePath),
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
                    _selectedImagePath == ''
                        ? Icon(
                            Icons.add,
                            size: 40,
                            color: dark_color,
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _productNameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'اسم المنتج',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _priceController,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'السعر',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _addressController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'العنوان',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'وصف المنتج',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: InkWell(
                          onTap: () {
                            _showColorPickerDialog(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.add,
                              color: dark_color,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Wrap(
                        children: _selectedColors.map((color) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              backgroundColor: color,
                              radius: 15,
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(width: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'ألوان متاحة',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: InkWell(
                          onTap: () {
                            _addSizeInputField();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.add,
                              color: dark_color,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Wrap(
                        children: _buildSizeInputFields(),
                      ),
                      SizedBox(width: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'الأحجام المتاحة',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSellSelected = false;
                          _isRentSelected = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: _isRentSelected ? gray_color : white_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: text_gray_color, width: 1),
                        ),
                        minimumSize: Size(145, 55),
                      ),
                      child: Text(
                        'تأجير',
                        style: TextStyle(
                          color: _isRentSelected ? dark_color : text_gray_color,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSellSelected = true;
                          _isRentSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: _isSellSelected ? gray_color : white_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: text_gray_color, width: 1),
                        ),
                        minimumSize: Size(145, 55),
                      ),
                      child: Text(
                        'بيع',
                        style: TextStyle(
                            color:
                                _isSellSelected ? dark_color : text_gray_color),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement save logic
                    },
                    style: ElevatedButton.styleFrom(
                      primary: purple_color, // Adjust color as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(380, 40),
                    ),
                    child: Text(
                      'حفظ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(
          currentPageIndex: 2,
          parentContext: context,
        ),
      ),
    );
  }

  List<Widget> _buildSizeInputFields() {
    List<Widget> sizeFields = [];
    double totalWidth = 0;

    for (var controller in _sizeControllers) {
      Widget sizeField = SizedBox(
        width: 50,
        height: 40,
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: '......',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(),
          ),
        ),
      );

      double fieldWidth = 60; // Default field width

      if (sizeFields.isNotEmpty) {
        fieldWidth += 10; // Add space between fields
      }

      totalWidth += fieldWidth;

      if (totalWidth > 400) {
        // If the total width exceeds 400, start a new row
        sizeFields.add(SizedBox(height: 10)); // Add space between rows
        totalWidth = fieldWidth; // Reset total width for the new row
      }

      sizeFields.add(sizeField);
    }

    return sizeFields;
  }

  void _showColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color pickedColor = dark_color;

        return AlertDialog(
          title: Text('اختر لونًا'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickedColor,
              onColorChanged: (Color color) {
                pickedColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedColors.add(pickedColor);
                });
                Navigator.of(context).pop();
              },
              child: Text('تم'),
            ),
          ],
        );
      },
    );
  }

  void _addSizeInputField() {
    setState(() {
      _sizeControllers.add(TextEditingController());
    });
  }

  void _selectImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }
}
