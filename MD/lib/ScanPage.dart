import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'ScanResult.dart';
import 'components/TopBar.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController _cameraController;
  late int _selectedCameraIndex;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first);
    _cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await _cameraController.initialize();
    _selectedCameraIndex = cameras.indexOf(frontCamera);
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _switchCamera() async {
    final cameras = await availableCameras();

    final newCameraIndex = (_selectedCameraIndex + 1) % cameras.length;

    await _cameraController.dispose();
    _cameraController =
        CameraController(cameras[newCameraIndex], ResolutionPreset.medium);
    await _cameraController.initialize();

    setState(() {
      _selectedCameraIndex = newCameraIndex;
    });
  }

  Future<void> _captureImage() async {
    if (!_cameraController.value.isInitialized) {
      return;
    }

    final XFile imageFile = await _cameraController.takePicture();
    final File file = File(imageFile.path);

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanResult(imageFile: file),
      ),
    );
  }

  Future<void> _uploadFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final XFile imageFile = XFile(pickedFile.path);

      final File file = File(imageFile.path);

      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanResult(imageFile: file),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          TopBar(title: 'Scan your face', fontSize: 20.0),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF05729D),
                width: 5.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CameraPreview(_cameraController),
          ),
          Container(
            margin: EdgeInsets.only(top: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _uploadFromGallery,
                  icon: Icon(Icons.photo_library),
                  iconSize: 36.0,
                  color: Color(0xFF05729D),
                ),
                IconButton(
                  onPressed: _captureImage,
                  icon: Icon(Icons.camera),
                  iconSize: 64.0,
                  color: Color(0xFF05729D),
                ),
                IconButton(
                  onPressed: _switchCamera,
                  icon: Icon(Icons.switch_camera),
                  iconSize: 36.0,
                  color: Color(0xFF05729D),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
