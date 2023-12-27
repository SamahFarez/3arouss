import 'package:flutter/material.dart';
import '../shared/colors.dart';

class ToggleButtonsWidget extends StatelessWidget {
  final List<String> buttonTitles;
  final ValueChanged<int> onButtonTapped;
  final int selectedIndex;

  ToggleButtonsWidget({
    required this.buttonTitles,
    required this.onButtonTapped,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        width: 450, // Set the width here
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            buttonTitles.length,
            (index) => _buildToggleButton(index),
          ).reversed.toList(), // Reverse the order of buttons
        ),
      ),
    );
  }

  Widget _buildToggleButton(int index) {
    bool isSelected = index == selectedIndex;

    return ElevatedButton(
      onPressed: () {
        onButtonTapped(index);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return gray_color; // Use the provided color when pressed
            }
            return isSelected ? gray_color : white_color; // Customize as needed
          },
        ),
        fixedSize: MaterialStateProperty.all(
          Size(115, 30),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Text(
        buttonTitles[index],
        style: TextStyle(color: isSelected ? dark_color : dark_color),
      ),
    );
  }
}


/*to use it, it's like this 
 ToggleButtonsWidget(
                buttonTitles: ['One', 'Two', 'Three'], // Customize button texts
                selectedIndex: _selectedStatus.index,
                onButtonTapped: (index) {
                  setState(() {
                    _displayedRequestList = _filterRequestsByStatus(_statusList[index]);
                    _selectedStatus = _statusList[index];
                  });
                },
                ),
*/