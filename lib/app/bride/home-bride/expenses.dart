import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';

class Expense {
  final String itemName;
  final double price;
  final DateTime date;

  Expense({required this.itemName, required this.price, required this.date});
}

class ExpenseTrackingPage extends StatefulWidget {
  @override
  _ExpenseTrackingPageState createState() => _ExpenseTrackingPageState();
}

class _ExpenseTrackingPageState extends State<ExpenseTrackingPage> {
  List<Expense> _expensesList = [
    Expense(itemName: 'عشاء', price: 50.0, date: DateTime.now()),
    Expense(itemName: 'ديكور', price: 30.0, date: DateTime.now()),
    // Add more expenses as needed
  ];

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
              SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: dark_color),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 140),
                  Text(
                    'تتبع النفقات',
                    style: TextStyle(color: dark_color, fontSize: 18),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'الإجمالي المدفوع',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: dark_color, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' دج',
                                  style: TextStyle(
                                    color: dark_blue_color,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${_calculateTotalSpent()}',
                                  style: TextStyle(
                                    color: dark_blue_color,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _expensesList.isEmpty
                    ? Center(
                        child: Text(
                          'لا توجد نفقات مسجلة.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: dark_color),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _expensesList.length,
                        itemBuilder: (context, index) {
                          return _buildExpenseItem(_expensesList[index]);
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExpenseDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: dark_blue_color,
      ),
      bottomNavigationBar: Container(
        child: CustomBottomNavigationBar(
          currentPageIndex: 1,
          parentContext: context,
        ),
      ),
    );
  }

  double _calculateTotalSpent() {
    double total = 0.0;
    for (var expense in _expensesList) {
      total += expense.price;
    }
    return total;
  }

Widget _buildExpenseItem(Expense expense) {
  return GestureDetector(
    onTap: () {
      _showExpenseDetailsDialog(expense);
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        onPressed: () {},
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('دج', style: TextStyle(color: dark_color)),
                  Text('${expense.price.toStringAsFixed(2)}', style: TextStyle(color: dark_color)),
                ],
              ),
              Text(expense.itemName, style: TextStyle(color: dark_color)),
            ],
          ),
        ),
      ),
    ),
  );
}

  void _showAddExpenseDialog(BuildContext context) {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'إضافة نفقة',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          content: Container(
            height: 160,
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: itemNameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'اسم العنصر',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: gray_color,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'السعر',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: gray_color,
                        width: 1,
                      ),
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
                      color: dark_blue_color,
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
                        style: TextStyle(color: dark_blue_color),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: dark_blue_color,
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
                      String itemName = itemNameController.text.trim();
                      String priceText = priceController.text.trim();

                      if (itemName.isNotEmpty && priceText.isNotEmpty) {
                        double price = double.parse(priceText);
                        setState(() {
                          _expensesList.add(
                            Expense(
                              itemName: itemName,
                              price: price,
                              date: DateTime.now(),
                            ),
                          );
                        });
                      }
                      itemNameController.clear();
                      priceController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'إضافة نفقة',
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

   void _showExpenseDetailsDialog(Expense expense) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تفاصيل النفقة',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          content: Container(
            height: 150,
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('العنصر: ${expense.itemName}'),
                Text('السعر: دج ${expense.price}'),
                Text('تاريخ الشراء: ${_formatDate(expense.date)}'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteExpense(expense);
                Navigator.of(context).pop();
              },
              child: Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    // Implement your preferred date formatting logic here
    return "${date.day}/${date.month}/${date.year}";
  }

  void _deleteExpense(Expense expense) {
    setState(() {
      _expensesList.remove(expense);
    });
  }
}

  


