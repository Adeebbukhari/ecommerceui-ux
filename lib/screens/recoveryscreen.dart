import 'package:flutter/material.dart';

// Main Widget Class: Recovery Screen for resetting password
class RecoveryScreen extends StatefulWidget {
  RecoveryScreen({super.key});

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

// State Class
class _RecoveryScreenState extends State<RecoveryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // No background color
        elevation: 0, // No shadow
        foregroundColor: Colors.black, // AppBar text/icons color
      ),

      // Scrollable Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15), // Horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10), // Spacing from top

              // Heading Text
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 50), // Spacing before OTP field

              // OTP Input Field
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter Otp", // Label text
                  prefixIcon: Icon(Icons.numbers), // Prefix icon for OTP
                  border: OutlineInputBorder(), // Rounded border
                ),
              ),

              SizedBox(height: 30), // Spacing between fields

              // Password Input Field
              TextField(
                decoration: InputDecoration(
                  labelText: "Password", // Label text
                  prefixIcon: Icon(Icons.password), // Prefix icon
                  suffixIcon: Icon(Icons.remove_red_eye), // Eye icon for visibility toggle
                  border: OutlineInputBorder(), // Rounded border
                ),
              ),

              SizedBox(height: 30), // Spacing

              // Confirm Password Input Field
              TextField(
                decoration: InputDecoration(
                  labelText: "Confirm Password", // Label text
                  prefixIcon: Icon(Icons.password), // Prefix icon
                  suffixIcon: Icon(Icons.remove_red_eye), // Eye icon for visibility toggle
                  border: OutlineInputBorder(), // Rounded border
                ),
              ),

              SizedBox(height: 30), // Spacing before button

              // Reset Password Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Add reset password logic here
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(55), // Button height
                  backgroundColor: Color(0xffef6969), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

              SizedBox(height: 20), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
