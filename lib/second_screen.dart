import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}
class _SecondScreenState extends State<SecondScreen> {
  late CameraController _controller;
  late Future<void> _controllerInitialization;

  @override
  void initState() {
    super.initState();
    _controllerInitialization = initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: FutureBuilder<void>(
        future: _controllerInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_controller.value.isInitialized) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              );
            } else {
              return Center(
                child: Text('Camera initialization failed'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
