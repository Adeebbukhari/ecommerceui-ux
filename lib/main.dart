import 'package:ecommerce/screens/loginscreen.dart';
import 'package:ecommerce/screens/navigationscreen.dart';
import 'package:ecommerce/screens/onboardingscreen.dart';
import 'package:ecommerce/screens/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: "Ecommerce",
        theme: ThemeData(
        primaryColor: Color(0xFFEF6969),
    ),
      home: SplashScreen(),
    );
  }
}


