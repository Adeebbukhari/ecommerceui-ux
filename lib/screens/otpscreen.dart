// Importing the next OTP verification screen
import 'package:ecommerce/screens/otpvverfiyscreen.dart';

// Importing Flutter Material package for UI components
import 'package:flutter/material.dart';

// Stateful widget because the OTP screen may need dynamic changes
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key}); // Constructor with optional key

  @override
  State<OtpScreen> createState() => _OtpScreenState(); // Creates state for this widget
}

// State class for OtpScreen
class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure of the screen
    return Scaffold(
      // Transparent AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // No background
        foregroundColor: Colors.black, // Text and icon color
        elevation: 0, // Removes shadow
      ),

      // Scrollable body to avoid overflow on small screens
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.0), // Horizontal padding
          child: Column(
            children: [
              SizedBox(height: 10), // Space at the top

              // Heading aligned to the top-left
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Otp Verification", // Screen title
                  style: TextStyle(
                    fontSize: 30, // Large font
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ),

              SizedBox(height: 20), // Space below title

              // Description explaining OTP process
              Text(
                "Please Enter Your number. You will receive an message which consists Otp",
                style: TextStyle(
                  fontSize: 15, // Normal font
                ),
              ),

              SizedBox(height: 30), // Space before input field

              // TextField for entering mobile number
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter Mobile Number", // Label for input
                  border: OutlineInputBorder(), // Box around input field
                ),
              ),

              SizedBox(height: 30), // Space before button

              // Button to send OTP
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next OTP verification screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Otpvverfiyscreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(55), // Button height
                  backgroundColor: Color(0xffef6969), // Red background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  "Send Code", // Button text
                  style: TextStyle(
                    color: Colors.white, // White text color
                    fontSize: 18, // Font size
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
