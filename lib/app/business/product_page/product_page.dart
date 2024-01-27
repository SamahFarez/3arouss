import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_business.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert'; // Add this import for jsonEncode
import 'package:http/http.dart'
    as http; // Add this import for making HTTP requests
// Other imports...

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
  String _selectedProductType = 'الملابس'; // Default type, you can change this

  String _selectedHaircutType = 'تسريحة العروس الكلاسيكية';

  List<String> _selectedSizes = [];
  List<String> _availableSizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL',
    '36',
    '38',
    '40',
    '42',
    '44'
  ];

  Map<String, List<String>> subcategories = {
    'الملابس': [
      'قفطان',
      'برنوس',
      'أحذية',
      'مجوهرات'
    ],
    'تصفيف الشعر': [
      'برنوس',
      'أحذية ',
      'مجوهرات '
    ],
    // Add subcategories for other main categories
  };

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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  width: MediaQuery.of(context).size.width *
                      0.7, // Set to 70% of screen width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: _selectedProductType,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProductType = newValue!;
                          });
                        },
                        items: subcategories.keys.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                // Add your text style here
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        value: subcategories[_selectedProductType]![0],
                        onChanged: (String? newValue) {
                          setState(() {
                            subcategories[_selectedProductType]!
                                .remove(newValue!);
                            subcategories[_selectedProductType]!.insert(0, newValue);
                          });
                        },
                        items: subcategories[_selectedProductType]!
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.right,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
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
                    hintStyle: TextStyle(color: text_gray_color),
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
                    hintStyle: TextStyle(color: text_gray_color),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _addressController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'العنوان',
                    hintStyle: TextStyle(color: text_gray_color),
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
                    hintStyle: TextStyle(color: text_gray_color),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Conditionally render product-specific fields
                _buildProductSpecificFields(),

                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement save logic
                      _saveProduct();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: purple_color,
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

  Widget _buildTransactionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTransactionButton(
          label: 'تأجير',
          isSelected: _isRentSelected,
          onPressed: () {
            setState(() {
              _isSellSelected = false;
              _isRentSelected = true;
            });
          },
        ),
        SizedBox(width: 30),
        _buildTransactionButton(
          label: 'بيع',
          isSelected: _isSellSelected,
          onPressed: () {
            setState(() {
              _isSellSelected = true;
              _isRentSelected = false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTransactionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: isSelected ? gray_color : white_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: text_gray_color, width: 1),
        ),
        minimumSize: Size(145, 55),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? dark_color : text_gray_color,
        ),
      ),
    );
  }

// Add a new case for 'Party Rooms' in _buildProductSpecificFields
  Widget _buildProductSpecificFields() {
    print('Selected Product Type: $_selectedProductType');
    switch (_selectedProductType) {
      case 'الملابس':
        return _buildClothesFields();
      case 'تصفيف الشعر':
        return _buildHairStylingFields();
      case 'صالات الحفلات':
        return _buildPartyRoomFields(); // Add this line
      case 'الأحذية':
        return _buildShoesFields();
      case 'الحلويات':
        return _buildSweetsFields();
      case 'الإكسسوارات':
        return _buildAccessoriesFields();
      case 'الديكور':
        return _buildDecorFields();
      case 'المصورين':
        return _buildPhotographersFields();
      // Add other product types as needed
      default:
        return SizedBox.shrink(); // Default case, no specific fields
    }
  }

  Widget _buildShoesFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Implement UI for shoes-specific fields
        // _buildSizeInputFields(), // Change this line
        // Include transaction buttons
        SizedBox(height: 20),
        _buildTransactionButtons(),
      ],
    );
  }

  Widget _buildSweetsFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }

  Widget _buildAccessoriesFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Implement UI for accessories-specific fields

        // Include transaction buttons
        SizedBox(height: 20),
        _buildTransactionButtons(),
      ],
    );
  }

  Widget _buildDecorFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Implement UI for decor-specific fields

        // Include transaction buttons
        SizedBox(height: 20),
        _buildTransactionButtons(),
      ],
    );
  }

  Widget _buildPhotographersFields() {
    return Column(
      children: [],
    );
  }

// Create a new method for building fields specific to Party Rooms
  Widget _buildPartyRoomFields() {
    return Column(
      children: [
        TextFormField(
          // Add field for dimensions of the room
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: 'أبعاد الغرفة',
            hintStyle: TextStyle(color: text_gray_color),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          // Add field for number of seats
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'عدد المقاعد',
            hintStyle: TextStyle(color: text_gray_color),
            border: OutlineInputBorder(),
          ),
        ),
        // Add other fields as needed
      ],
    );
  }

  Widget _buildClothesFields() {
    return Column(
      children: [
        // _buildColorPicker(),
        SizedBox(height: 20),
        // _buildSizeInputFields(), // Change this line
        SizedBox(height: 20),
        _buildTransactionButtons(),
      ],
    );
  }

  Widget _buildHairStylingFields() {
    return Column(
      children: [
        // Add a dropdown for selecting the type of haircut
        DropdownButton<String>(
          value: _selectedHaircutType,
          onChanged: (String? newValue) {
            setState(() {
              _selectedHaircutType = newValue!;
            });
          },
          items: <String>[
            'تسريحة العروس الكلاسيكية', // Classic Bride Hairstyle
            'تسريحة الشعر الملفوف', // Wrapped Hair Hairstyle
            'تسريحة الكانتري', // Country-style Hairstyle
            'تسريحة السفرة', // Traditional Table Hairstyle
            'تسريحة الأميرة', // Princess Hairstyle
            // Add other Algerian wedding-related female hairstyles as needed
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        SizedBox(height: 20),
        _buildTransactionButtons(),
      ],
    );
  }
  Widget _buildColorPicker() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            ':ألوان متاحة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: text_gray_color,
            ),
          ),
          Wrap(
            children: [
              Container(
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: text_gray_color, width: 1),
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
              SizedBox(width: 5),
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
            ],
          )
        ],
      ),
    );
  }

  // Widget _buildSizeInputFields() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       Text(
  //         ':اختر الأحجام',
  //         style: TextStyle(
  //           color: text_gray_color,
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(height: 10),
  //       Wrap(
  //         alignment: WrapAlignment.end,
  //         children: _availableSizes.map((size) {
  //           bool isSelected = _selectedSizes.contains(size);
  //           return GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 if (isSelected) {
  //                   _selectedSizes.remove(size);
  //                 } else {
  //                   _selectedSizes.add(size);
  //                 }
  //               });
  //             },
  //             child: Container(
  //               padding: EdgeInsets.all(8),
  //               margin: EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                 color: isSelected ? blue_color : gray_color,
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Text(
  //                 size,
  //                 style: TextStyle(
  //                   color: isSelected ? text_gray_color : text_gray_color,
  //                 ),
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     ],
  //   );
  // }

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

  void _saveProduct() async {
    // Prepare product data
    Map<String, dynamic> productData = {
      'publication_name': _productNameController.text,
      'publication_type': _selectedProductType,
      'publication_price': _priceController.text,
      'business_id': 'YOUR_BUSINESS_ID', // Replace with your business ID
      'publication_content': _descriptionController.text,
      'publication_image_url':
          'URL_TO_YOUR_IMAGE', // Replace with image URL or path
      'publication_date': DateTime.now().toString(),
      // Add other fields as needed
    };

    // Send product data to Flask API
    // Make sure to replace "FLASK_API_URL" with the actual URL of your Flask API
    final response = await http.post(
      Uri.parse('FLASK_API_URL/insert_publication'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(productData),
    );

    // Handle the API response
    if (response.statusCode == 200) {
      // Product inserted successfully
      // You can show a success message or navigate to another screen
      print('Publication inserted successfully');
    } else {
      // Error inserting product
      // You can show an error message
      print('Error inserting publication');
    }
  }
}
