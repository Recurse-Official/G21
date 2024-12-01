import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stash_fund/components/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Signup",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Helvetica',
              ),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDF4F2),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: usernameController,
                style: const TextStyle(fontFamily: 'Helvetica'),
                decoration: const InputDecoration(
                  labelText: "Enter Your Username",
                  labelStyle: TextStyle(fontFamily: 'Helvetica'),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDF4F2),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: emailController,
                style: const TextStyle(fontFamily: 'Helvetica'),
                decoration: const InputDecoration(
                  labelText: "Enter Your Email",
                  labelStyle: TextStyle(fontFamily: 'Helvetica'),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDF4F2),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: phoneController,
                style: const TextStyle(fontFamily: 'Helvetica'),
                decoration: const InputDecoration(
                  labelText: "Enter Your Phone Number",
                  labelStyle: TextStyle(fontFamily: 'Helvetica'),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDF4F2),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                style: const TextStyle(fontFamily: 'Helvetica'),
                decoration: InputDecoration(
                  labelText: "Enter Your Password",
                  labelStyle: const TextStyle(fontFamily: 'Helvetica'),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  authProvider.signup(
                    usernameController.text,
                    emailController.text,
                    phoneController.text,
                    passwordController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/form');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF31473A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Signup",
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontFamily: 'Helvetica'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
