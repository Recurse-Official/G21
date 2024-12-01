import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stash_fund/components/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
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
              "Welcome back",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Helvetica',
              ),
            ),
            const Text(
              "Enter your credentials for login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'Helvetica',
              ),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDF4F2), // Box color as #EDF4F2
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: emailController,
                style: const TextStyle(fontFamily: 'Helvetica'),
                decoration: const InputDecoration(
                  labelText: "Enter Your Username / Email",
                  labelStyle: TextStyle(fontFamily: 'Helvetica'),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDF4F2), // Box color as #EDF4F2
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
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Makes the button take the full width
              child: ElevatedButton(
                onPressed: () {
                  if (authProvider.login(
                    emailController.text,
                    passwordController.text,
                  )) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Invalid credentials!",
                          style: TextStyle(fontFamily: 'Helvetica'),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF31473A), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Circular radius
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontFamily: 'Helvetica', color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle forgot password
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(fontFamily: 'Helvetica',color:  Color(0xFF31473A),fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontFamily: 'Helvetica'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    "Signup",
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
