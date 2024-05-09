import 'dart:convert';
import 'package:bisleriumbloggers/controllers/Authentication/Auth_apis.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/widgets/gradient_button.dart';
import 'package:bisleriumbloggers/utilities/widgets/login_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String username = usernameController.text.trim();

    final Map<String, dynamic> result = await login(username, email, password);

    if (result['success']) {
      GoRouter.of(context).push(Uri(path: '/').toString());
    } else {
      String errorMessage = 'Invalid credentials';
      final errorBody = jsonDecode(result['error']);

      if (errorBody.containsKey('errors')) {
        final errors = errorBody['errors'];
        if (errors.containsKey('Email')) {
          errorMessage = errors['Email'][0];
        }
      }

      _showErrorDialog('Login Failed', errorMessage);
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
                'Log In.',
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
                hintText: 'Username',
                controller: usernameController,
                keywordtype: TextInputType.text,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New to Bislerium Bloggers? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: BisleriumColor.whiteColor,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .push(Uri(path: '/username').toString());
                    },
                    child: const Text(
                      'Sign up',
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
                buttonText: "Log In",
                onPressed: _login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
