import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SucessEmailPage extends StatelessWidget {
  const SucessEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn.create.vista.com/api/media/small/347167394/stock-vector-white-envelope-check-mark-icon-isolated-long-shadow-successful-mail',
              width: 450,
              height: 450,
            ),
            SizedBox(height: 20),
            Text(
              'Check Your Email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please check the email address associated with the username for instruction to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(Uri(path: '/login').toString());
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
