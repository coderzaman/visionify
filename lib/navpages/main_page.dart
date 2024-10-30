
import 'package:flutter/material.dart';
import 'package:visionify/navpages/camera_page.dart';
import 'package:visionify/navpages/home_page.dart';
import 'package:visionify/navpages/profile_page.dart';
import 'package:visionify/navpages/upload_image_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    CameraPage(),
    UploadImagePage(),
    MyPage()
  ];
  int current_index = 0;
  void onTap(int index){
      setState(() {
        current_index = index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[current_index],
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 32,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: current_index,
          selectedIconTheme: IconThemeData(color: Colors.black54),
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.apps),
            ),
            BottomNavigationBarItem(
              label: "Bar",
              icon: Icon(Icons.camera),
            ),
            BottomNavigationBarItem(
              label: "Search",
              icon: Icon(Icons.upload_file),
            ),
            BottomNavigationBarItem(
              label: "My",
              icon: Icon(Icons.person),
            )
          ]),
    );
  }
}
