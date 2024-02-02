import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import 'category_result.dart';
import '../../widgets/bottom_navigation_bar_bride.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

final Dio dio = Dio();

Future<List<Map<String, dynamic>>> getCategoriesData() async {
  print("getting data....");

  String endpoint = 'https://3arouss-app-flask.vercel.app/bride_categories.get';

  print("Endpoint: $endpoint");

  try {
    var response = await dio.get(endpoint);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> dataList = [];

      if (response.data is Map<String, dynamic>) {
        Map<String, dynamic> jsonData = response.data;

        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          dataList = List<Map<String, dynamic>>.from(jsonData['data']);
          print("Requests data: ${dataList}");
        } else {
          print("Error: 'data' key not found or not a list");
        }
      } else {
        print("Error: Response is not a Map");
      }

      return dataList;
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (error) {
    print("Error: $error");
  }

  return [];
}

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category>? categories;

  @override
  void initState() {
    super.initState();
    populateCategory();
  }

  Future<void> populateCategory() async {
    List<Map<String, dynamic>>? requestData = await getCategoriesData();
    categories = [];

    if (requestData != null && requestData.isNotEmpty) {
      for (var data in requestData) {
        categories!.add(
          Category(
            name: data['category_name'] ?? 'N/A',
            id: data['category_id'] ?? -1,
          ),
        );
      }
    } else {
      print('Error: Request data is null or empty');
    }

    setState(() {});
  }

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
          padding: EdgeInsets.only(top: 200),
          child: SingleChildScrollView(
            child: (categories == null || categories!.isEmpty)
                ? CircularProgressIndicator() // Show loading indicator
                : Column(
                    children: categories!.map((Category category) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryResult( categoryName: category.name,
                                      categoryId: category.id,),
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
        child: CustomBottomNavigationBar(
          currentPageIndex: 1,
          parentContext: context,
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final int id;

  Category({
    required this.name,
    required this.id,
  });
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
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
            style: TextStyle(
                color: dark_color, fontSize: 16.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
