//jangan lupa dihubungkan dulu ke firebase
import 'package:flutter/material.dart';
import 'package:logininterface/main-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
    );
  }
}
