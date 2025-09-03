import 'package:ecommerce/screens/otpscreen.dart';
import 'package:ecommerce/screens/recoveryscreen.dart';
import 'package:flutter/material.dart';

// Main Widget Class
class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

// State Class
class _ForgotScreenState extends State<ForgotScreen> {
  // This variable will control whether the button color should change
  bool clrButton = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with transparent background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      // Scrollable Body
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(height: 10),

              // Heading
               Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

               SizedBox(height: 50),

              // Description text
              Text(
                "Please Enter Your E-mail Address. You will receive an email which consists Otp",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),

               SizedBox(height: 30),

              // TextField for email input
              TextField(
                controller: emailController,
                onChanged: (val) {
                  // Trigger color change if the value is not empty
                  setState(() {
                    clrButton = val.trim().isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Email", // ✅ Correct usage of labelText
                  border:  OutlineInputBorder(), // ✅ Corrected usage
                  suffixIcon: IconButton( // ✅ suffixIcon instead of suffix
                    onPressed: () {
                      setState(() {
                        emailController.clear();
                      });
                    },
                    icon:  Icon(Icons.cancel),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecoveryScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(55),
                  backgroundColor: Color(0xffef6969),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:  Text(
                  "Send Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Verify Using number ??",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OtpScreen()),
                        );
                      },
                      child: Text("Verify Now ",
                        style: TextStyle(
                            color: Color(0xffef6969,),
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      )
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
