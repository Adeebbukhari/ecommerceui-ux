import 'package:flutter/material.dart';
import 'package:ecommerce/screens/homescreen.dart';
import 'package:ecommerce/screens/loginscreen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      body: SingleChildScrollView(
        child: Center(
            child: SafeArea(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    Image.asset("assets/images/freed.png"),
                    SizedBox(height: 30,),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Enter Name",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Enter Email",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Enter Mobile Number",
                                prefixIcon: Icon(Icons.numbers),
                                border: OutlineInputBorder(
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: Icon(Icons.remove_red_eye),
                                labelText: "Enter Password",
                                border: OutlineInputBorder(
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: Icon(Icons.remove_red_eye),
                                labelText: "Confirm Password",
                                border: OutlineInputBorder(
                                )
                            ),
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(55),
                              backgroundColor: Color(0xffef6969),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Create an account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have account ?? ",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54
                                ),
                              ),
                              TextButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Loginscreen()),
                                    );
                                  },
                                  child: Text("Log In",
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
                    )
                  ],
                ))),
      ),
    );
  }
}