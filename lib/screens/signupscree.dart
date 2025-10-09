import 'package:ecommerce/screens/navigationscreen.dart'; // Navigation after signup
import 'package:flutter/material.dart'; // Flutter widgets
import 'package:ecommerce/screens/loginscreen.dart'; // Navigate to login screen
import 'package:ecommerce/storage/user_storage.dart'; // ✅ Import for local data storage

class SignUpScreen extends StatefulWidget { // Signup page
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>(); // Form validation key

  final _nameController = TextEditingController(); // Name input
  final _emailController = TextEditingController(); // Email input
  final _mobileController = TextEditingController(); // Mobile input
  final _passwordController = TextEditingController(); // Password input
  final _confirmPasswordController = TextEditingController(); // Confirm password input

  bool _isPasswordVisible = false; // Toggle password
  bool _isConfirmPasswordVisible = false; // Toggle confirm password

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) => (value==null||value.isEmpty) ? "Email required" : (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value) ? "Enter valid email" : null);
  String? _validateMobile(String? value) => (value==null||value.isEmpty) ? "Mobile required" : (value.length!=10 ? "Must be 10 digits" : null);
  String? _validatePassword(String? value) => (value==null||value.isEmpty) ? "Password required" : (value.length<6 ? "At least 6 chars" : null);
  String? _validateConfirmPassword(String? value) => (value==null||value.isEmpty) ? "Confirm required" : (value!=_passwordController.text ? "Passwords do not match" : null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Scrollable page
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction, // Live validation
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50), // Spacer
                    Image.asset("assets/images/freed.png"), // Logo
                    const SizedBox(height: 30),

                    // Name input
                    TextFormField(controller: _nameController, autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(labelText: "Enter Name", prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                      validator: (value) => (value==null||value.isEmpty) ? "Name required" : null,
                    ),
                    const SizedBox(height: 15),

                    // Email input
                    TextFormField(controller: _emailController, autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(labelText: "Enter Email", prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 15),

                    // Mobile input
                    TextFormField(controller: _mobileController, keyboardType: TextInputType.number, autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(labelText: "Enter Mobile Number", prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                      validator: _validateMobile,
                    ),
                    const SizedBox(height: 15),

                    // Password input
                    TextFormField(controller: _passwordController, obscureText: !_isPasswordVisible, autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        labelText: "Enter Password",
                        border: const OutlineInputBorder(),
                      ),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 15),

                    // Confirm password input
                    TextFormField(controller: _confirmPasswordController, obscureText: !_isConfirmPasswordVisible, autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                        ),
                        labelText: "Confirm Password",
                        border: const OutlineInputBorder(),
                      ),
                      validator: _validateConfirmPassword,
                    ),
                    const SizedBox(height: 20),

                    // Create account button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // ✅ Save data locally
                          await UserStorage.saveUserData(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            mobile: _mobileController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          // Navigate to next screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => NavigationScreen()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(55),
                        backgroundColor: const Color(0xffef6969),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Create an account", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    const SizedBox(height: 10),

                    // Login redirect
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Already have account ?? ", style: TextStyle(fontSize: 15, color: Colors.black54)),
                      TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const Loginscreen())),
                        child: const Text("Log In", style: TextStyle(color: Color(0xffef6969), fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
