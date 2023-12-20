import 'package:flutter/material.dart';
import '../../../shared/images.dart';
import '../../../shared/colors.dart';
import '../home_bride.dart';
import 'category_result.dart'; // Import the CategoryResult widget
import '../favorites/favorite_publication.dart';
import '../profile/profile_bride.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'ملابس'),
    Category(name: 'أحذية'),
    Category(name: 'مجوهرات'),
    Category(name: 'ديكور'),
    Category(name: 'قاعات حفلات'),
    Category(name: 'مصففات الشعر'),
    Category(name: 'حلويات'),
    Category(name: 'فوتوغرافر'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(background_image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 190),
          child: SingleChildScrollView(
            child: Column(
              children: categories.map((Category category) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to CategoryResult when a category is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryResult(categoryName: category.name),
                      ),
                    );
                  },
                  child: CategoryCard(category: category),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          boxShadow: [BoxShadow(color: dark_color, blurRadius: 5)],
        ),
        child: BottomAppBar(
          color: white_color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: ImageIcon(AssetImage(home_icon)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrideHomePage()),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(categories_outlined_icon)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(star_outlined_icon)),
                onPressed: () {},
              ),
              IconButton(
                icon: ImageIcon(AssetImage(heart_outlined_icon)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoritePublicationScreen()),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(profile_outlined_icon)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  final String name;

  Category({required this.name});
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: double.infinity,
        height: 80,
        child: Center(
          child: Text(
            category.name,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
