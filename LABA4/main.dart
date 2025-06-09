import 'package:flutter/material.dart';
import 'screens/main_screen_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор ускорения',
      home: MainScreenProvider(),
    );
  }
}