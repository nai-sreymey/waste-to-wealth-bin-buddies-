import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Enter your Username address to reset your password.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              // Email Input Field
              Container(
                decoration: _inputDecoration(),
                child: TextField(
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
              const SizedBox(height: 30),
              
              // Send Reset Link Button
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
                  onPressed: () {
                    // Here you would trigger the reset password logic
                    // For now, it will show a snack bar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password reset link sent')),
                    );
                  },
                  child: const Text(
                    "Send Reset Link",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
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
