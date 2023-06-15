import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Glowsist/scanPage.dart';
import 'components/TopBar.dart';

class ScanSuggestion extends StatelessWidget {
  Future<bool> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    return status.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          TopBar(title: 'Make your selfie better', fontSize: 20.0),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF05729D),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'How to get the most out of your photos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Divider(color: Color(0xFF05729D)),
                      Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/clear_makeup.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '1. Clear your makeup',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/trim_hair.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(width: 8), // Jarak antara gambar dan teks
                          Text(
                            '2. Tidy your hair back',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/remove_eyeglasses.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '3. Take off your glasses',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/natural_face.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '4. Selfie with your natural face',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'lib/assets/icons/lightning.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '5. Make sure your place is well lit',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF05729D),
              padding: EdgeInsets.only(left: 32, right: 32),
              elevation: 0,
            ),
            onPressed: () async {
              bool isCameraPermissionGranted = await _requestCameraPermission();
              if (isCameraPermissionGranted) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanPage()),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Izin Kamera Diperlukan'),
                    content: Text(
                        'Untuk menggunakan fitur ini, izinkan akses kamera.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text(
              'Selfie now',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
