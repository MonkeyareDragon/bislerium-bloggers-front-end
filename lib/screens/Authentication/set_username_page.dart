import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/widgets/gradient_button.dart';
import 'package:bisleriumbloggers/utilities/widgets/login_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SetUsernamePage extends StatefulWidget {
  const SetUsernamePage({super.key});

  @override
  State<SetUsernamePage> createState() => _SetUsernamePage();
}

class _SetUsernamePage extends State<SetUsernamePage> {
  final usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Set Your Username.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Bislerium.whiteColor,
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Username',
                controller: usernameController,
                keywordtype: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              GradientButton(
                buttonText: "Next",
                onPressed: () {
                  final username = usernameController.text;
                  GoRouter.of(context).push(Uri(
                    path: '/register/$username',
                  ).toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
