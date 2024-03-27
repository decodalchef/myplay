import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/home.dart';
// import 'package:get/get.dart;';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      title: 'My Play',
      theme: ThemeData(
        fontFamily: "PlayfairDisplay",
            appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        elevation: 0,
        ),
      ),
    );
  }
}
