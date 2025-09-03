import 'package:ecommerce/screens/navigationscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ecommerce/screens/onboardingscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 4),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ✅ Fix: Use width as screen width, not height
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/image2.jpg"),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(
              Icons.shopping_cart,
              size: 250,
              color: Color(0xfffe6969),
            ),
            SizedBox(height: 20), // spacing
            Text(
              "Shop Now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
