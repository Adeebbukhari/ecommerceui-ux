import 'package:ecommerce/screens/navigationscreen.dart'; // Navigate after login
import 'package:ecommerce/screens/signupscree.dart'; // Navigate to signup
import 'package:flutter/material.dart'; // Flutter widgets
import 'package:ecommerce/screens/forgotscreen.dart'; // Navigate to forgot password
import 'package:ecommerce/storage/user_storage.dart'; // ✅ Access saved email & password

class Loginscreen extends StatefulWidget { // Login page
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>(); // Form key

  final _emailController = TextEditingController(); // Email input
  final _passwordController = TextEditingController(); // Password input

  bool _isPasswordVisible = false; // Toggle password visibility

  @override
  void dispose() {
    _emailController.dispose(); // Dispose controllers
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) => (value == null || value.isEmpty)
      ? "Email required"
      : (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
      .hasMatch(value)
      ? "Enter valid email"
      : null);

  String? _validatePassword(String? value) =>
      (value == null || value.isEmpty)
          ? "Password required"
          : (value.length < 6 ? "At least 6 chars" : null);

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      // ✅ Fetch saved data from SharedPreferences
      final userData = await UserStorage.getUserData();
      final savedEmail = userData['email'];
      final savedPassword = userData['password'];

      if (savedEmail == null || savedPassword == null) {
        // No user data found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No account found. Please sign up first."),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      // ✅ Check email & password match
      if (_emailController.text.trim() == savedEmail &&
          _passwordController.text.trim() == savedPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationScreen()),
        );
      } else {
        // ❌ Invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid email or password"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Scrollable
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 140), // Spacer
                Image.asset("assets/images/freed.png"), // Logo
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction, // Live validation
                    child: Column(
                      children: [
                        // Email input
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              labelText: "Enter Email",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder()),
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 15),

                        // Password input
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => setState(() =>
                              _isPasswordVisible = !_isPasswordVisible),
                            ),
                            labelText: "Enter Password",
                            border: const OutlineInputBorder(),
                          ),
                          validator: _validatePassword,
                        ),

                        // Forgot password
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const ForgotScreen())),
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: Color(0xffef6969),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ✅ Login button
                        ElevatedButton(
                          onPressed: _loginUser,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(55),
                            backgroundColor: const Color(0xffef6969),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Log In",
                              style:
                              TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        const SizedBox(height: 10),

                        // Sign up redirect
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't Have an Account ?? ",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54)),
                              TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const SignUpScreen())),
                                child: const Text("Sign Up",
                                    style: TextStyle(
                                        color: Color(0xffef6969),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ]),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
