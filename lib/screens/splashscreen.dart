import 'package:ecommerce/screens/loginscreen.dart'; // Login screen to navigate after splash
import 'package:ecommerce/screens/signupscree.dart'; // Signup screen (not used currently)
import 'package:flutter/material.dart'; // Flutter UI widgets
import 'dart:async'; // Timer for splash delay

// Main widget for Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer to navigate to Login screen after 4 seconds
    Timer(
      Duration(seconds: 4),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginscreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Full screen container
      body: Container(
        height: MediaQuery.of(context).size.height, // Full screen height
        width: MediaQuery.of(context).size.width, // Full screen width
        decoration: BoxDecoration(
          color: Colors.black, // Base color
          image: DecorationImage(
            image: AssetImage("assets/images/image2.jpg"), // Background image
            fit: BoxFit.cover, // Cover entire container
            opacity: 0.4, // Image transparency
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            // Shopping cart icon
            Icon(
              Icons.shopping_cart,
              size: 250,
              color: Color(0xfffe6969),
            ),
            SizedBox(height: 20), // Spacing
            // "Shop Now" text
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
