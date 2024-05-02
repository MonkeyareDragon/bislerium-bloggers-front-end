import 'package:bisleriumbloggers/utilities/routes/auth_service.dart';
import 'package:bisleriumbloggers/utilities/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      color: Colors.amber[50],
      width: 500,
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logpic.jpg', // Replace 'logo.png' with your image path
            width: 150,
            height: 150,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Username'),
          ),
          SizedBox(height: 20),
          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                AuthService.authenticated = true;
                GoRouter.of(context).go(AppRoutes.DashboardRoute);
              },
              child: const Text("Login")),
        ],
      ),
    )));
  }
}
