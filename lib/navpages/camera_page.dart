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
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Fetch available cameras
    _cameras = await availableCameras();
    _initializeSelectedCamera();
  }

  Future<void> _initializeSelectedCamera() async {
    // Dispose of any existing controller
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }

    // Initialize the selected camera
    _cameraController = CameraController(
      _cameras![_selectedCameraIndex],
      ResolutionPreset.medium,
    );

    // Initialize the controller future
    _initializeControllerFuture = _cameraController!.initialize();

    setState(() {});
  }

  void _switchCamera() {
    // Toggle between front and back camera
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
    _initializeSelectedCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _startImageDetection() {
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
            left: 20,
            child: FloatingActionButton(
              onPressed: _switchCamera,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.switch_camera),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
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
