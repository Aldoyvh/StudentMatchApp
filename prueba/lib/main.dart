import 'package:flutter/material.dart';
import 'package:prueba/HomeScreen.dart';
import 'package:prueba/camera.dart';
import 'package:prueba/login.dart';
import 'package:prueba/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn(),
    );
  }
}
