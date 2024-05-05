import 'dart:convert';

import 'package:bisleriumbloggers/controllers/Authentication/auth_apis.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/widgets/gradient_button.dart';
import 'package:bisleriumbloggers/utilities/widgets/login_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  final String username;
  const RegisterPage({
    super.key,
    required this.username,
  });

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();
    final String username = widget.username;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog('Missing Information',
          'All fields are required to filled up to proceed.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog('Acceptance Required',
          'Please accept our Privacy Policy and Terms of Use.');
      return;
    }

    final Map<String, dynamic> result =
        await register(username, email, password, confirmPassword);

    if (result['success']) {
    } else {
      String errorMessage = 'Invalid credentials';
      print(result);
      final errorBody = jsonDecode(result['error']);

      if (errorBody.containsKey('errors')) {
        final errors = errorBody['errors'];
        if (errors.containsKey('description')) {
          errorMessage = errors['description'][0];
        }
      }

      _showErrorDialog('Registration Failed', errorMessage);
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BisleriumColor.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Sign Up.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: BisleriumColor.whiteColor,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Email',
                controller: emailController,
                keywordtype: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Password',
                controller: passwordController,
                // obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                // obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already a Bislerium Bloggers? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: BisleriumColor.whiteColor,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(Uri(path: '/login').toString());
                    },
                    child: const Text(
                      'Login In',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: BisleriumColor.gradient2,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        decorationColor: BisleriumColor.gradient2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GradientButton(
                buttonText: "Sign Up",
                onPressed: _register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
