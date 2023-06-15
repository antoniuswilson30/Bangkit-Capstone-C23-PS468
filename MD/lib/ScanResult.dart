import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:Glowsist/main.dart';
import 'package:http/http.dart' as http;
import 'package:Glowsist/ScanPage.dart';
import 'components/TopBar.dart';

class ScanResult extends StatelessWidget {
  final File imageFile;

  ScanResult({required this.imageFile});

  Future<String> sendImageToAPI() async {
    final url = Uri.parse('https://c23-ps468-me25i7itza-et.a.run.app/scans');

    var request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      return jsonResponse.toString();
    } else {
      return 'Error: ${response.statusCode}';
    }
  }

  String capitalize(String str) {
    if (str.isEmpty) {
      return str;
    }
    return str[0].toUpperCase() + str.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder<String>(
        future: sendImageToAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(height: 10),
                Text("Analyzing...")
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final responseText = snapshot.data ?? '';
            final responseList =
                responseText.replaceAll('{', '').replaceAll('}', '').split(',');

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TopBar(title: 'Result', fontSize: 20.0),
                Center(
                  child: Container(
                    width: 300,
                    height: 450,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(8), // Jarak antara kotak dengan elemen lainnya
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF05729D),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'The results of your facial analysis',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var item in responseList)
                              ..._buildResultContainerWidgets(item),
                          ],
                        ),
                      ],
                    ),
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
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScanPage()),
                          );
                        },
                        child: Text(
                          'Scan again',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF05729D),
                          padding: EdgeInsets.only(left: 24.0, right: 24.0),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        child: Text(
                          'Back to home',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildResultContainerWidgets(String item) {
    final keyValue = item.split(':');
    final value = keyValue[1].trim();

    return [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF05729D),
          borderRadius: BorderRadius.circular(
              10), // Mengatur radius lingkaran untuk pinggiran bulat
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
