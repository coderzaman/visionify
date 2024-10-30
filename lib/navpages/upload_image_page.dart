// import 'package:flutter/cupertino.dart';
//
// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Center(
//       child: const Text("Upload Images"),
//     ));
//   }
// }

// import 'package:flutter/cupertino.dart';
//
// class BarItemPage extends StatelessWidget {
//   const BarItemPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Center(
//       child: const Text("Turn On The Camera"),
//     ));
//   }
// }


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
        backgroundColor: Color(0xFFF6F6F6),
        elevation: 1.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
              _imageFile!,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/upload-default.png', // Replace with your default image path
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
