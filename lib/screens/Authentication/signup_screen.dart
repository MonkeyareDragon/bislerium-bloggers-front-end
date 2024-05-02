import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/widgets/gradient_button.dart';
import 'package:bisleriumbloggers/utilities/widgets/login_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Sign Up.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Bislerium.whiteColor,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 15),
              const LoginField(hintText: 'Email'),
              const SizedBox(height: 15),
              const LoginField(hintText: 'Password'),
              const SizedBox(height: 15),
              const LoginField(hintText: 'Confirm Password'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already a Bislerium Bloggers? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Bislerium.whiteColor,
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
                        color: Bislerium.gradient2,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        decorationColor: Bislerium.gradient2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const GradientButton(
                buttonText: "Sign Up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
