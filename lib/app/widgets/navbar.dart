import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final List<NavItem> navItems;
  final Function(int) onTabSelected;
  final int selectedIndex;

  CustomNavBar({required this.navItems, required this.onTabSelected, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: navItems
          .asMap()
          .map((index, navItem) => MapEntry(
                index,
                BottomNavigationBarItem(
                  icon: Icon(navItem.icon),
                  label: navItem.label,
                ),
              ))
          .values
          .toList(),
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      selectedItemColor: Colors.black, // Set the color for the selected item
      unselectedItemColor: Colors.grey, // Set the color for unselected items
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;

  NavItem({required this.icon, required this.label});
}
