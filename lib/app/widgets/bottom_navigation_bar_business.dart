import 'package:flutter/material.dart';
import '../shared/images.dart';
import '../shared/colors.dart';
import '../business/home-business/home_business.dart';
import '../business/comments_page/comments_page.dart';
import '../business/requests_business/requests_page.dart';
import '../business/product_page/product_page.dart';
import '../business/profile/profile_business.dart';

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
            buildIconButton(0, home_icon, home_outlined_icon, BusinessHomePage()),
            buildIconButton(1, inbox_image, inbox_outlined_image, RequestsPage()),
            buildIconButton(2, add_icon, add_outlined_icon, AddProductPage()),
            buildIconButton(3, star_icon, star_outlined_icon, CommentsListPage()),
            buildIconButton(4, profile_icon, profile_outlined_icon, BusinessProfileScreen()),
          ],
        ),
      ),
    );
  }

  IconButton buildIconButton(int index, String iconImage, String outlinedIcon, Widget? page) {
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
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        }
      },
    );
  }
}
