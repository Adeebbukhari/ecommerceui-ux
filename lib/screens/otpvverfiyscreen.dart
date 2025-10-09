// Importing the recovery screen to navigate after OTP verification
import 'package:ecommerce/screens/recoveryscreen.dart';

// Importing Flutter Material package for UI components
import 'package:flutter/material.dart';

// Importing SMS autofill package to automatically read OTP
import 'package:sms_autofill/sms_autofill.dart';

// Stateful widget because OTP value updates dynamically
class Otpvverfiyscreen extends StatefulWidget {
  const Otpvverfiyscreen({super.key}); // Constructor with optional key

  @override
  State<Otpvverfiyscreen> createState() => _OtpvverfiyscreenState(); // Creates the state
}

// State class implementing CodeAutoFill to receive OTP automatically
class _OtpvverfiyscreenState extends State<Otpvverfiyscreen> with CodeAutoFill {
  // Controller for the OTP input field
  TextEditingController textEditingController = TextEditingController(text: "");

  // Variable to store received OTP
  String? _receivedOtp;

  // Method to get the app signature (required by SMS autofill)
  _getSignatureCode() async {
    String? signature = await SmsAutoFill().getAppSignature;
    print("App Signature: $signature"); // Prints signature in console
  }

  // Method called when the OTP is updated automatically
  @override
  void codeUpdated() {
    setState(() {
      _receivedOtp = code; // Update local OTP variable
      textEditingController.text = code ?? ''; // Fill the text field
    });
    print("Received OTP: $_receivedOtp"); // Debug print OTP
  }

  @override
  void initState() {
    super.initState();
    _getSignatureCode(); // Fetch app signature
    listenForCode(); // Start listening for incoming OTP
  }

  @override
  void dispose() {
    cancel(); // Stop listening for OTP when screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // No background
        foregroundColor: Colors.black, // Black icons/text
        elevation: 0, // No shadow
      ),

      // Scrollable body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.0), // Horizontal padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              SizedBox(height: 10), // Top spacing

              // Screen title aligned to the top-left
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Enter OTP", // Heading text
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 60), // Space before OTP field

              // OTP input field with autofill support
              PinFieldAutoFill(
                controller: textEditingController, // Text controller
                codeLength: 4, // OTP length
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black), // Text style
                  colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)), // Underline color
                ),
                onCodeChanged: (code) {
                  print("Typed OTP: $code"); // Print typed OTP
                },
              ),

              SizedBox(height: 30), // Space before button

              // Button to proceed after OTP entry
              ElevatedButton(
                onPressed: () {
                  // Add OTP verification logic if needed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecoveryScreen()), // Navigate to recovery screen
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(55), // Button height
                  backgroundColor: Color(0xffef6969), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  "Reset Password", // Button text
                  style: TextStyle(color: Colors.white, fontSize: 18), // Text style
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
