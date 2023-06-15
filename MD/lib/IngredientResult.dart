import 'package:flutter/material.dart';
import 'package:Glowsist/IngredientForm.dart';
import 'package:Glowsist/main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:async';

import 'components/TopBar.dart';

class IngredientResult extends StatelessWidget {
  final Map<String, String> formData;

  IngredientResult({required this.formData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Result(formData: formData),
    );
  }
}

class Result extends StatefulWidget {
  final Map<String, String> formData;

  Result({required this.formData});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> responseIngredient = [];
  List<dynamic> responseProduct = [];

  late Map<String, String> formData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    formData = widget.formData;
    postData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> postData() async {
    setState(() {
      isLoading = true;
    });

    var url =
        Uri.parse('https://c23-ps468-me25i7itza-et.a.run.app/recomendations');
    var headers = {'Content-Type': 'application/json'};

    var data = {
      "acne": formData['acne'],
      "redness": formData['redness'],
      "skintype": formData['skintype'],
      "sensitivity": formData['sensitivity']
    };

    var body = jsonEncode(data);

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        responseIngredient = jsonResponse['ingredients_results'] != null
            ? List<dynamic>.from(jsonResponse['ingredients_results'])
            : [];
        responseProduct = jsonResponse['product_results'] != null
            ? List<dynamic>.from(jsonResponse['product_results'])
            : [];
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  String capitalize(String str) {
    if (str.isEmpty) {
      return str;
    }
    return str[0].toUpperCase() + str.substring(1);
  }

  Widget buildListTile(String title, List<String> values) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Color(0xFF05729D)),
            ...values
                .map((value) => Text(
                      capitalize(value.trim()),
                      style:
                          TextStyle(color: Color(0xFF05729D), fontSize: 14.0),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget buildListTileProducts(String title, List<String> values) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(0xFF333333),
              ),
            ),
            Divider(color: Color(0xFF05729D)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: values.asMap().entries.map((entry) {
            final index = entry.key;
            final value = entry.value;
            if (index.isEven) {
              return Text(
                value,
                style: TextStyle(color: Color(0xFF333333)),
              );
            } else {
              final imageIndex = (index ~/ 2) % 5;
              return Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'lib/assets/images/products/product$imageIndex.png',
                        width: 100,
                        height: 100,
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final linkValue =
                                  value.replaceAll('Link product :', '').trim();
                              final Uri productLink = Uri.parse(linkValue);
                              launchUrl(productLink);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF05729D),
                              padding: EdgeInsets.all(8),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart),
                                SizedBox(width: 5.0),
                                Text(
                                  'Buy now',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              );
            }
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16),
            child: TopBar(title: 'Result', fontSize: 28.0)),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.black54,
            tabs: [
              Tab(
                  child: Text(
                'Ingredients Recommendation',
                style: TextStyle(color: Color(0xFF05729D), fontSize: 12.0),
              )),
              Tab(
                  child: Text(
                'Products Recommendation',
                style: TextStyle(color: Color(0xFF05729D), fontSize: 12.0),
              )),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(height: 10),
                          Text("Analyzing...")
                        ],
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: responseIngredient.length,
                        itemBuilder: (context, index) {
                          final item = responseIngredient[index];
                          final title = "Best for " +
                              capitalize(item.keys
                                  .toString()
                                  .replaceAll('(', '')
                                  .replaceAll(")", ''));
                          final values = item.values
                              .toString()
                              .replaceAll('([', '')
                              .replaceAll('])', '')
                              .split(',');

                          return buildListTile(title, values);
                        },
                      ),
                isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(height: 10),
                          Text("Analyzing...")
                        ],
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: responseProduct.length,
                        itemBuilder: (context, index) {
                          final item = responseProduct[index];
                          final title = "Best products for " +
                              capitalize(item.keys
                                  .toString()
                                  .replaceAll('(', '')
                                  .replaceAll(")", ''));
                          final values = item.values
                              .toString()
                              .replaceAll('([{', '')
                              .replaceAll('}])', '')
                              .replaceAll('{', '')
                              .replaceAll('}', '')
                              .replaceAll('product:', 'Product :')
                              .replaceAll('product_url:', 'Link product :')
                              .replaceAll('Dear,', 'Dear :')
                              .split(',');

                          return buildListTileProducts(title, values);
                        },
                      ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF05729D),
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IngredientForm()),
                    );
                  },
                  child: Text(
                    'Analyze again',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF05729D),
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Text(
                    'Back to home',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
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
