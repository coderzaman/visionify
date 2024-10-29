import 'package:flutter/material.dart';
import 'package:visionify/dashboard.dart';
import 'package:visionify/signup.dart';
import 'package:visionify/signin.dart';
import 'package:visionify/signuporsigninscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF229799)),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}
