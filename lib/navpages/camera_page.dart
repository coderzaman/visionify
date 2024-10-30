import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Fetch the available cameras
    final cameras = await availableCameras();
    // Select the first camera (usually the rear camera)
    final firstCamera = cameras.first;

    // Initialize the controller
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    // Initialize the controller future
    _initializeControllerFuture = _cameraController!.initialize();

    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _startImageDetection() {
    // Placeholder for future image detection functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image detection started')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Preview"),
        backgroundColor: Color(0xFFF6F6F6),
        elevation: 2.0,
      ),
      body: _initializeControllerFuture == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 20,
            child: FloatingActionButton(
              onPressed: _startImageDetection,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
