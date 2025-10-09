// Importing OTP screen for navigation when user verifies using number
import 'package:ecommerce/screens/otpscreen.dart';

// Importing recovery screen to handle password reset process
import 'package:ecommerce/screens/recoveryscreen.dart';

// Importing Flutter Material package for UI components
import 'package:flutter/material.dart';

// Main widget class (stateful because UI updates dynamically)
class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key}); // Constructor with optional key

  @override
  State<ForgotScreen> createState() => _ForgotScreenState(); // Creates state for widget
}

// State class containing logic and UI
class _ForgotScreenState extends State<ForgotScreen> {
  // Boolean variable to track whether the button should be active or not
  bool clrButton = false;

  // Controller for email TextField to read or clear user input
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Scaffold provides base page structure
    return Scaffold(
      // Transparent AppBar at top
      appBar: AppBar(
        backgroundColor: Colors.transparent, // No background color
        elevation: 0, // Removes shadow
        foregroundColor: Colors.black, // Makes icons/text black
      ),

      // Body scrollable for small screens
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15), // Horizontal padding for layout
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
            children: [
              SizedBox(height: 10), // Space at top

              // Page title
              Text(
                "Forgot Password", // Title text
                style: TextStyle(
                  fontSize: 30, // Large font
                  fontWeight: FontWeight.bold, // Bold style
                ),
              ),

              SizedBox(height: 50), // Space between title and description

              // Description text explaining process
              Text(
                "Please Enter Your E-mail Address. You will receive an email which consists Otp",
                style: TextStyle(
                  fontSize: 15, // Normal font size
                ),
              ),

              SizedBox(height: 30), // Space below description

              // Email input field
              TextField(
                controller: emailController, // Connects input with controller
                onChanged: (val) {
                  // Whenever user types, check if text is not empty
                  setState(() {
                    clrButton = val.trim().isNotEmpty; // Enable button if field filled
                  });
                },
                decoration: InputDecoration(
                  labelText: "Email", // Label displayed above input
                  border: OutlineInputBorder(), // Bordered box design
                  suffixIcon: IconButton( // Button inside text field (right side)
                    onPressed: () {
                      // Clears the email field when cancel icon pressed
                      setState(() {
                        emailController.clear();
                      });
                    },
                    icon: Icon(Icons.cancel), // Cancel (X) icon
                  ),
                ),
              ),

              SizedBox(height: 30), // Space before button

              // Button to send recovery code
              ElevatedButton(
                onPressed: () {
                  // Navigate to Recovery Screen when clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecoveryScreen()),
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

              SizedBox(height: 5), // Small gap before verify section

              // Row for alternate verification option
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                children: [
                  // Message text
                  Text(
                    "Verify Using number ??",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54, // Slightly faded black
                    ),
                  ),

                  // Button for "Verify Now" navigation
                  TextButton(
                    onPressed: () {
                      // Navigates to OTP verification screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OtpScreen()),
                      );
                    },
                    child: Text(
                      "Verify Now ",
                      style: TextStyle(
                        color: Color(0xffef6969), // Red color text
                        fontSize: 16,
                        fontWeight: FontWeight.w600, // Semi-bold text
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
