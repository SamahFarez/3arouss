import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../home-bride/home_bride.dart';
import 'categories.dart';
import 'publication.dart';
import '../favorites/favorite_publication.dart';
import '../requests/requests.dart';
import '../profile/profile_bride.dart';

class CategoryResult extends StatelessWidget {
  final String categoryName;
  final List<String> buttonTexts = [
    'برنوس',
    'كاراكو',
    'قفطان',
    'قبايلي',
    'قسنطينية'
  ];

  CategoryResult({required this.categoryName});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 200.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: dark_color),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 140),
                Text(
                  categoryName,
                  style: TextStyle(fontSize: 24.0, color: dark_color),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buttonTexts.map((text) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: white_color,
                      ),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16.0, color: dark_color),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: gray_color),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'أقصى سعر',
                        fillColor: white_color,
                        filled: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      value: null,
                      onChanged: (String? newValue) {},
                      items: <String>['10000', '20000', '15000']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Container(
                  width: 160.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: gray_color),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'المنطقة',
                        fillColor: white_color,
                        filled: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      value: null,
                      onChanged: (String? newValue) {},
                      items: <String>['معالمة', 'خيار2', 'خير3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the PublicationPage with the selected card's image
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PublicationPage(imagePath: dress_image),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              dress_image,
                              fit: BoxFit.cover,
                            ),
                            Positioned.fill(
                              child: Transform.scale(
                                scale: 1.1, // Adjust the scale factor as needed
                                child: Image.asset(
                                  product_decoration_image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 6.0,
                              left: 15.0, // Adjust left padding
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'برنوس ',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: dark_color),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '25000 دج',
                                    style: TextStyle(
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.bold,
                                        color: dark_blue_color),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5.0),
          ],
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequestsScreen()),
                  );
                },
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
