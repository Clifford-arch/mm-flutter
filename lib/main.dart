import 'package:flutter/material.dart';
import 'package:mmflutter/pages/chart.dart';
// import 'package:mmflutter/pages/chart.dart';
import 'package:mmflutter/pages/home.dart';
import 'package:mmflutter/pages/retake.dart';
import 'package:mmflutter/pages/work.dart';
// import 'package:mmflutter/pages/home.dart';
// import 'package:mmflutter/pages/test.dart';
// import 'dart:math';

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
      title: 'Hello',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: WorkPage(),
    );
  }
}
