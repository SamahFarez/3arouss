import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';
import 'home_bride.dart';

enum FoodCategory {
  mainDish,
  dessert,
  appetizer,
}

class FoodItem {
  final String name;
  final FoodCategory category;

  FoodItem({
    required this.name,
    required this.category,
  });
}

class FoodListPage extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List<FoodItem> _foodList = [];
  List<FoodItem> _displayedFoodList = [];
  TextEditingController _foodNameController = TextEditingController();
  FoodCategory _selectedCategory = FoodCategory.mainDish; // Add this line

  @override
  void initState() {
    super.initState();
    _displayedFoodList = List.from(_foodList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              background_image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                SizedBox(height: 220),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCategoryButton(
                        'تحلية',
                        purple_color,
                        FoodCategory.dessert,
                      ),
                      _buildCategoryButton(
                        'طبق رئيسي',
                        blue_color,
                        FoodCategory.mainDish,
                      ),
                      _buildCategoryButton(
                        'مقبلات',
                        gray_color,
                        FoodCategory.appetizer,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _displayedFoodList.isEmpty
                      ? Center(
                          child: Text(
                            'لا يوجد عناصر',
                            style: TextStyle(color: dark_color),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _displayedFoodList.length,
                          itemBuilder: (context, index) {
                            return _buildFoodItem(_displayedFoodList[index]);
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddFoodDialog(context);
          },
          backgroundColor: purple_color, // Change the background color
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: Container(
          child: CustomBottomNavigationBar(),
        ));
  }

  Widget _buildCategoryButton(
      String title, Color color, FoodCategory category) {
    return ElevatedButton(
      onPressed: () {
        // Logic to filter and display food items based on the selected category
        setState(() {
          _displayedFoodList = _filterFoodByCategory(category);
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        fixedSize: MaterialStateProperty.all(
          Size(110, 40),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: white_color),
      ),
    );
  }

  List<FoodItem> _filterFoodByCategory(FoodCategory category) {
    return _foodList.where((food) => food.category == category).toList();
  }

  Widget _buildFoodItem(FoodItem food) {
    return ElevatedButton(
      onPressed: () {
        _showChangeCategoryDialog(context, food);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(white_color),
        fixedSize: MaterialStateProperty.all(
          Size(double.infinity, 50),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(food.name, style: TextStyle(color: dark_color)),
          ],
        ),
      ),
    );
  }

  void _changeCategory(FoodItem food, FoodCategory newCategory) {
    setState(() {
      int index = _foodList.indexOf(food);
      _foodList[index] = FoodItem(
        name: food.name,
        category: newCategory,
      );
    });
  }

  void _showChangeCategoryDialog(BuildContext context, FoodItem food) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تغيير الفئة',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          content: Container(
            height: 200,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildChangeCategoryButton(
                  'طبق الرئيسي',
                  blue_color,
                  FoodCategory.mainDish,
                  onPressed: () {
                    _changeCategory(food, FoodCategory.mainDish);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                _buildChangeCategoryButton(
                  'تحلية',
                  purple_color,
                  FoodCategory.dessert,
                  onPressed: () {
                    _changeCategory(food, FoodCategory.dessert);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                _buildChangeCategoryButton(
                  'مقبلات',
                  gray_color,
                  FoodCategory.appetizer,
                  onPressed: () {
                    _changeCategory(food, FoodCategory.appetizer);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChangeCategoryButton(
      String title, Color color, FoodCategory category,
      {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        fixedSize: MaterialStateProperty.all(
          Size(150, 30),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: white_color),
      ),
    );
  }

  void _showAddFoodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'إضافة طبق',
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          content: Container(
            height: 150,
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200,
                  height: 55,
                  child: TextField(
                    controller: _foodNameController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'اسم الطبق',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 55,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonFormField<FoodCategory>(
                      value:
                          _selectedCategory, // Use a variable to store the selected category
                      onChanged: (FoodCategory? value) {
                        setState(() {
                          _selectedCategory =
                              value!; // Update the selected category
                        });
                      },
                      items: FoodCategory.values.map((FoodCategory category) {
                        return DropdownMenuItem<FoodCategory>(
                          value: category,
                          child: Text(_getCategoryText(category)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: purple_color,
                      width: 2.0,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'إلغاء',
                        style: TextStyle(color: purple_color),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: purple_color, // Change button color to purple_color
                    boxShadow: [
                      BoxShadow(
                        color: dark_color.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 0.8,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      String foodName = _foodNameController.text.trim();
                      if (foodName.isNotEmpty) {
                        setState(() {
                          _foodList.add(
                            FoodItem(
                              name: foodName,
                              category:
                                  _selectedCategory, // Use the selected category
                            ),
                          );
                        });
                      }
                      _foodNameController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'إضافة طبق',
                        style: TextStyle(color: white_color),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  String _getCategoryText(FoodCategory category) {
    switch (category) {
      case FoodCategory.mainDish:
        return 'طبق رئيسي';
      case FoodCategory.dessert:
        return 'تحلية';
      case FoodCategory.appetizer:
        return 'مقبلات';
    }
  }
}
