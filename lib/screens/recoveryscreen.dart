import 'package:flutter/material.dart';

// Main Widget Class
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

              TextField(
                decoration: InputDecoration(
                  labelText: "Enter Otp",
                  prefixIcon: Icon(Icons.numbers),
                  border:  OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),

              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border:  OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),

              TextField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border:  OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),

              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomeScreen()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(55),
                  backgroundColor: Color(0xffef6969),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:  Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

               SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
