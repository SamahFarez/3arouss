import 'package:flutter/material.dart';
import '../../shared/images.dart';
import '../../shared/colors.dart';
import '../home-bride/home_bride.dart';
import 'categories.dart';
import 'publication.dart';
import '../favorites/favorite_publication.dart';
import '../requests/requests.dart';
import '../profile/profile_bride.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

final Dio dio = Dio();

Future<List<Map<String, dynamic>>> getSubcategory(categoryId) async {
  print("getting data....");

  String endpoint =
      'https://3arouss-app-flask.vercel.app/bride_subcategories.get/${categoryId}';

  print("Endpoint: $endpoint");

  try {
    var response = await dio.get(endpoint);

    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      List<Map<String, dynamic>> dataList = [];

      // Check if the response is a Map
      if (response.data is Map<String, dynamic>) {
        Map<String, dynamic> jsonData = response.data;

        // Check if the 'data' key exists and is a list
        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          dataList = List<Map<String, dynamic>>.from(jsonData['data']);
          print(dataList);
        } else {
          print("Error: 'data' key not found or not a list");
        }
      } else {
        print("Error: Response is not a Map");
      }

      return dataList;
    } else {
      // Handle HTTP error
      print("Error: ${response.statusCode}");
    }
  } catch (error) {
    // Handle other errors
    print("Error: $error");
  }

  return [];
}

class CategoryResult extends StatefulWidget {
  final String categoryName;
  final int categoryId;

  CategoryResult({
    required this.categoryName,
    required this.categoryId,
  });

  @override
  _CategoryResultState createState() => _CategoryResultState();
}

class _CategoryResultState extends State<CategoryResult> {
  List<String> buttonTexts = [];
  List<Map<String, dynamic>>? publicationsData;

  @override
  void initState() {
    super.initState();
    _populateCategory();
    _fetchPublications();
  }

  Future<void> _populateCategory() async {
    List<Map<String, dynamic>>? requestData =
        await getSubcategory(widget.categoryId);
    buttonTexts = [];

    if (requestData != null && requestData.isNotEmpty) {
      for (var data in requestData) {
        buttonTexts.add(data['subcategory_name'] ?? 'N/A');
      }
    } else {
      print('Error: Request data is null or empty');
    }

    setState(() {}); // Trigger a rebuild after updating buttonTexts
  }

  Future<void> _fetchPublications() async {
    String endpoint =
        'https://3arouss-app-flask.vercel.app/retrieve_publications.get';

    try {
      var response = await dio.get(endpoint);

      if (response.statusCode == 200) {
        print("Publications Response data: ${response.data}");
        if (response.data is Map<String, dynamic>) {
          Map<String, dynamic> jsonData = response.data;

          if (jsonData.containsKey('data') && jsonData['data'] is List) {
            publicationsData =
                List<Map<String, dynamic>>.from(jsonData['data']);
            print(publicationsData);
          } else {
            print("Error: 'data' key not found or not a list");
          }
        } else {
          print("Error: Publications Response is not a Map");
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching publications: $error");
    }
  }

Future<List<Map<String, dynamic>>> _filterPublicationsBySubcategory(String subcategoryName) async {
  String endpoint =
'https://3arouss-app-flask.vercel.app/get_publications_by_subcategory.get/$subcategoryName';



  try {
    var response = await dio.get(endpoint);

    if (response.statusCode == 200) {
      print("Filtered Publications Response data: ${response.data}");
      if (response.data is Map<String, dynamic>) {
        Map<String, dynamic> jsonData = response.data;

        if (jsonData.containsKey('data') && jsonData['data'] is List) {
          return List<Map<String, dynamic>>.from(jsonData['data']);
        } else {
          print("Error: 'data' key not found or not a list");
        }
      } else {
        print("Error: Filtered Publications Response is not a Map");
      }
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (error) {
    print("Error fetching filtered publications: $error");
  }

  return [];
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
                  widget.categoryName,
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
                    onPressed: () {
                      _filterPublicationsBySubcategory(text).then((filteredPublications) {
                        setState(() {
                          publicationsData = filteredPublications;
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: white_color,
                    ),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 16.0, color: dark_color),
                    ),
                  )

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
                      items: <String>['معالمة', 'زرالدة', 'دويرة']
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
                  itemCount: publicationsData?.length ?? 0,
                  itemBuilder: (context, index) {
                    var publication = publicationsData![index];
                    var img = publication['publication_image_url'];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PublicationPage(
                              imagePath: "assets/${publication['publication_image_url']}.jpg" ?? '',
                              publicationName: publication['publication_name'] ?? '',
                              publicationPrice: publication['publication_price'] ?? '',
                              publicationId: publication['publication_id'] ?? '',
                              publicationtype: publication['transaction_type_id'] ?? '',
                              publicationcontent: publication['publication_content'] ?? '',

                            ),
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
                            "assets/${publication['publication_image_url']}.jpg" ?? '',
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
                                    publication['publication_name'] ?? '',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: dark_color,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${publication['publication_price'] ?? ''} دج',
                                    style: TextStyle(
                                      fontSize: 9.0,
                                      fontWeight: FontWeight.bold,
                                      color: dark_blue_color,
                                    ),
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
