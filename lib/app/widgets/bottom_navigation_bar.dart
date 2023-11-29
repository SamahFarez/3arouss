import 'package:flutter/material.dart';
import '../shared/images.dart'; // Make sure to adjust the path based on your project structure
import '../shared/colors.dart'; // Make sure to adjust the path based on your project structure
import '../bride/home-bride/home_bride.dart'; // Make sure to adjust the path based on your project structure

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        boxShadow: [BoxShadow(color: dark_color, blurRadius: 5)],
      ),
      child: BottomAppBar(
        color: white_color,          // Center both horizontally and vertically
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Vertically center the icons
            children: [
              IconButton(
                icon: ImageIcon(AssetImage(home_icon)),
                onPressed: () {
                  // Navigate to BrideHomePage without transition animation
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BrideHomePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child; // No transition animation
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: ImageIcon(AssetImage(categories_outlined_icon)),
                onPressed: () {},
              ),
              IconButton(
                icon: ImageIcon(AssetImage(star_outlined_icon)),
                onPressed: () {},
              ),
              IconButton(
                icon: ImageIcon(AssetImage(heart_outlined_icon)),
                onPressed: () {},
              ),
              IconButton(
                icon: ImageIcon(AssetImage(profile_outlined_icon)),
                onPressed: () {},
              ),
            ],
          ),
          
        ),
      
    );
    
  }
}
