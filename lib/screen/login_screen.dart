import 'package:flutter/material.dart';
import 'package:waste_friendly/controllers/user_controller.dart';
import '../screen/home_screen_page.dart'; // Import HomeScreen
import 'register_screen.dart'; // Import RegisterScreen
import 'forgot_screen.dart'; // Import ForgotPasswordScreen
import 'package:waste_friendly/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Check if the user is already logged in
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn'); // Check saved login status

    // Debugging log
    print('Login Status: $isLoggedIn');

    if (isLoggedIn == true) {
      // If the user is logged in, navigate to the HomeScreen directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Call the function to check login status when screen is loaded
  }

  // Create a login function using UserController
  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Use the UserController to handle the login
    final userController = UserController();  // Instantiate the controller
    final user = await userController.login(username, password);  // Login logic here

    if (user != null) {
      // On successful login, save the login status and navigate to HomeScreen
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true); // Save login status

      // Debugging log
      print('User logged in successfully.');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenPage()), // Redirect to HomeScreen
      );
    } else {
      // Show error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              // Email Input Field
              Container(
                decoration: _inputDecoration(),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.email, color: Colors.black),
                    ),
                    suffixIconConstraints: const BoxConstraints(minWidth: 40),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password Input Field
              Container(
                decoration: _inputDecoration(),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.lock, color: Colors.black),
                    ),
                    suffixIconConstraints: const BoxConstraints(minWidth: 40),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text("Remember me"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to Forgot Password Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF26606),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _login, // Trigger login when pressed
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Register Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to the RegisterScreen when clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Input Decoration
  BoxDecoration _inputDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
