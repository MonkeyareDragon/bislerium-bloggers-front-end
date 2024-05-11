import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessAdminCreationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/005/163/928/non_2x/account-has-been-registered-login-success-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg',
              width: 450,
              height: 450,
            ),
            SizedBox(height: 20),
            Text(
              'Admin Created Successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to the previous page or home page
                    GoRouter.of(context)
                        .push(Uri(path: '/dashboard').toString());
                  },
                  child: Text('Back'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to the previous page or home page
                    GoRouter.of(context).push(Uri(path: '/login').toString());
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
