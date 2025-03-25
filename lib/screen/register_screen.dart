import 'package:flutter/material.dart';
import 'success_screen.dart'; // Import SuccessScreen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool agreeToTerms = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function to handle registration logic
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Registration logic goes here (e.g., API call)
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match")),
        );
      } else if (!agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You must agree to the terms and conditions")),
        );
      } else {
        // Proceed with registration (API call can be added here)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful")),
        );

        // After registration, navigate to the Success screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SuccessScreen()), // Go to SuccessScreen
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),

                // Username Input Field
                _buildTextField("Username", Icons.email, false, _usernameController),
                const SizedBox(height: 15),

                // Password Input Field
                _buildTextField("Password", Icons.lock, true, _passwordController),
                const SizedBox(height: 15),

                // Confirm Password Input Field
                _buildTextField("Confirm Password", Icons.lock_outline, true, _confirmPasswordController),
                const SizedBox(height: 15),

                // Location Input Field
                _buildTextField("Location", Icons.place, false, _locationController),
                const SizedBox(height: 10),

                // Agree to Terms
                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeToTerms = value!;
                        });
                      },
                    ),
                    const Text("I agree to the terms and conditions"),
                  ],
                ),
                const SizedBox(height: 20),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF26606),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: _register,
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        // Navigate to Login Screen
                        Navigator.pop(context); // Go back to Login screen
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to Build Input Fields with Validation
  Widget _buildTextField(String hint, IconData icon, bool obscureText, TextEditingController controller) {
    return Container(
      decoration: _inputDecoration(),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(icon, color: Colors.black),
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 40),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hint is required';
          }
          return null;
        },
      ),
    );
  }

  // Custom Input Decoration
  BoxDecoration _inputDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
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
