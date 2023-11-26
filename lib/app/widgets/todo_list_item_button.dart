import 'package:flutter/material.dart';

class TodoListItemButton extends StatelessWidget {
  final String task;
  final String date;
  final bool isImportant;

  TodoListItemButton({
    required this.task,
    required this.date,
    this.isImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 331,
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 2,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 47,
                        height: 8,
                        child: Text(
                          'مهمة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF334155),
                            fontSize: 14,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      SizedBox(
                        width: 68,
                        height: 16,
                        child: Text(
                          date,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFFC6A6FF),
                            fontSize: 10,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.w400,
                            height: 0.20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1, color: Color(0xFF334155)),
                    borderRadius: BorderRadius.circular(4),
                    color: isImportant ? Color(0xFF334155) : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
