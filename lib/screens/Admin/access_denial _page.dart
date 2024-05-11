import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccessDenialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://media.istockphoto.com/id/1392644925/vector/data-stealing-malware-abstract-concept-vector-illustration.jpg?s=612x612&w=0&k=20&c=V6br_iBcrF4z_RWOipdN1lloOse9DH87wS6FYZEeDyo=',
              width: 450,
              height: 450,
            ),
            SizedBox(height: 20),
            Text(
              'Access Denied',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You do not have permission to access this page.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(Uri(path: '/').toString());
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
