import 'package:flutter/material.dart';
import 'package:flutteria/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interview Prep App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
