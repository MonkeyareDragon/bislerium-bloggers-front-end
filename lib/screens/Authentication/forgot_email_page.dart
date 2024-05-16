import 'package:bisleriumbloggers/controllers/Authentication/auth_apis.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/widgets/gradient_button.dart';
import 'package:bisleriumbloggers/utilities/widgets/login_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
                'Enter your email address to reset your password.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: BisleriumColor.whiteColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Email',
                controller: emailController,
                keywordtype: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              GradientButton(
                buttonText: "Next",
                onPressed: () async {
                  String email = emailController.text.trim();
                  bool success = await forgotPassword(email);
                  if (success) {
                    GoRouter.of(context)
                        .push(Uri(path: '/email-send').toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
