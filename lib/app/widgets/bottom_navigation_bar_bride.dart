import 'package:flutter/material.dart';
import '/app/bride/categories/categories.dart';
import '/app/bride/favorites/favorite_publication.dart';
import '/app/bride/profile/profile_bride.dart';
import '/app/bride/requests/requests.dart';
import '../shared/images.dart'; // Make sure to adjust the path based on your project structure
import '../shared/colors.dart'; // Make sure to adjust the path based on your project structure
import '../bride/home-bride/home_bride.dart'; // Make sure to adjust the path based on your project structure
import '../bride/home-bride/guests_list.dart'; // Make sure to adjust the path based on your project structure
import '../bride/home-bride/food_list.dart'; // Make sure to adjust the path based on your project structure

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final BuildContext parentContext;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentPageIndex,
    required this.parentContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        boxShadow: [BoxShadow(color: dark_color, blurRadius: 5)],
      ),
      child: BottomAppBar(
        color: white_color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildIconButton(0, home_icon, home_outlined_icon, BrideHomePage()),
            buildIconButton(1, categories_icon, categories_outlined_icon,
                CategoriesScreen()),
            buildIconButton(
                2, inbox_image, inbox_outlined_image, RequestsScreen()),
            buildIconButton(3, heart_icon, heart_outlined_icon,
                FavoritePublicationScreen()),
            buildIconButton(
                4, profile_icon, profile_outlined_icon, ProfileScreen()),
          ],
        ),
      ),
    );
  }

  IconButton buildIconButton(
      int index, String iconImage, String outlinedIcon, Widget? page) {
    return IconButton(
      icon: ImageIcon(
        AssetImage(currentPageIndex == index ? iconImage : outlinedIcon),
        color: currentPageIndex == index ? null : dark_color,
      ),
      onPressed: () {
        if (currentPageIndex != index && page != null) {
          Navigator.pushReplacement(
            parentContext,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        }
      },
    );
  }
}
