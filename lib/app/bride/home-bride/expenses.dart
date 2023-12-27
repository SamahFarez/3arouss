import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';
import '../../../databases/db_expense.dart';

class Expense {
  final int id;
  final String itemName;
  final double price;
  final DateTime date;

  Expense({
    required this.id,
    required this.itemName,
    required this.price,
    required this.date,
  });
}

class ExpenseTrackingPage extends StatefulWidget {
  @override
  _ExpenseTrackingPageState createState() => _ExpenseTrackingPageState();
}

class _ExpenseTrackingPageState extends State<ExpenseTrackingPage> {
  List<Expense> _expensesList = [];

  @override
  void initState() {
    super.initState();
    _loadExpensesFromDatabase();
  }

  Future<void> _loadExpensesFromDatabase() async {
    final expenses = await ExpenseDB.getAllExpenses();
    setState(() {
      _expensesList = expenses.map((expense) {
        return Expense(
          id: expense['id'],
          itemName: expense['title'],
          price: expense['price'],
          date: DateTime.parse(expense['date']),
        );
      }).toList();
    });
  }

  double _calculateTotalSpent() {
    double total = 0.0;
    for (var expense in _expensesList) {
      total += expense.price;
    }
    return total;
  }

  double _calculateRemainingAmount() {
    // Replace this with your actual logic for calculating total income
    double totalIncome = 0.0;

    // Calculate total expenses
    double totalExpenses = _calculateTotalSpent();

    // Calculate remaining amount
    double remainingAmount = totalIncome - totalExpenses;

    return remainingAmount;
  }

  Widget _buildExpenseItem(Expense expense) {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    itemNameController.text = expense.itemName;
    priceController.text = expense.price.toStringAsFixed(2);

    return GestureDetector(
      onTap: () {
        _showEditExpenseDialog(expense, itemNameController, priceController);
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
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: dark_color),
                        onPressed: () {
                          _showDeleteConfirmationDialog(expense);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: dark_blue_color),
                        onPressed: () {
                          _showEditExpenseDialog(
                              expense, itemNameController, priceController);
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('دج', style: TextStyle(color: dark_color)),
                    Text('${expense.price.toStringAsFixed(2)}',
                        style: TextStyle(color: dark_color)),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  expense.itemName,
                  style: TextStyle(color: dark_color, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditExpenseDialog(
    Expense expense,
    TextEditingController itemNameController,
    TextEditingController priceController,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تعديل العنصر'),
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                String itemName = itemNameController.text.trim();
                String priceText = priceController.text.trim();

                if (itemName.isNotEmpty && priceText.isNotEmpty) {
                  double price = double.parse(priceText);
                  final currentDate = DateTime.now();

                  // Update the expense in the database
                  await ExpenseDB.updateExpense({
                    'id': expense.id,
                    'title': itemName,
                    'price': price,
                    'date': currentDate.toIso8601String(),
                  });

                  // Reload expenses from the database
                  await _loadExpensesFromDatabase();
                }

                Navigator.of(context).pop();
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(Expense expense) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الحذف'),
          content: Text('هل أنت متأكد أنك تريد حذف هذا العنصر؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                // Delete the expense from the database
                await ExpenseDB.deleteExpense(expense.id);

                // Reload expenses from the database
                await _loadExpensesFromDatabase();

                Navigator.of(context).pop();
              },
              child: Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    bool isIncome = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                'إضافة مصروف',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              content: Container(
                height: 200,
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
                      controller: amountController,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'المبلغ',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10),
                        ToggleButtons(
                          children: [
                            Text('مصروف', style: TextStyle(color: white_color)),
                            Text('إيراد', style: TextStyle(color: white_color)),
                          ],
                          isSelected: [!isIncome, isIncome],
                          onPressed: (index) {
                            setState(() {
                              isIncome = index == 1;
                            });
                          },
                          fillColor: dark_blue_color,
                          borderColor: dark_blue_color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        Text(':نوع العملية'),
                      ],
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
                        horizontal: 0.0,
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
                        onPressed: () async {
                          String itemName = itemNameController.text.trim();
                          String amountText = amountController.text.trim();

                          if (itemName.isNotEmpty && amountText.isNotEmpty) {
                            double amount = double.parse(amountText);
                            if (isIncome) {
                              // Add to total for income
                              _calculateTotalSpent();
                            } else {
                              // Subtract from total for expense
                              _calculateTotalSpent();
                              amount =
                                  -amount; // Make the amount negative for expenses
                            }

                            final currentDate = DateTime.now();

                            // Insert the expense into the database
                            await ExpenseDB.insertExpense({
                              'title': itemName,
                              'price': amount,
                              'date': currentDate.toIso8601String(),
                              'create_date': currentDate.toIso8601String(),
                            });

                            // Reload expenses from the database
                            await _loadExpensesFromDatabase();
                          }

                          itemNameController.clear();
                          amountController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0,
                            horizontal: 10.0,
                          ),
                          child: Text(
                            'إضافة مصروف',
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
              onPressed: () async {
                // Delete the expense from the database
                await ExpenseDB.deleteExpense(expense.id);

                // Reload expenses from the database
                await _loadExpensesFromDatabase();
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
    return "${date.day}/${date.month}/${date.year}";
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
                                  '${_calculateRemainingAmount()}',
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
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'الرصيد المتبقي',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: dark_color, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              '${_calculateTotalSpent()}دج ',
                              style: TextStyle(
                                color: dark_blue_color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
}
