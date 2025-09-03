import 'package:flutter/material.dart';
import 'package:ecommerce/screens/homescreen.dart';
import 'package:ecommerce/screens/signupscree.dart';
import 'package:ecommerce/screens/forgotscreen.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

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
              SizedBox(height: 140,),
              Image.asset("assets/images/freed.png"),
              SizedBox(height: 50,),
              Padding(padding:  EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
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
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          labelText: "Enter Password",
                          border: OutlineInputBorder(
                          )
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotScreen(),));
                      },
                          child: Text("Forgot Password",
                            style: TextStyle(
                                color: Color(0xffef6969,),
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
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
                      child:  Text(
                        "Log In",
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
                        Text("Don't Have an Account ?? ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                          ),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                              },
                            child: Text("Sign Up",
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
