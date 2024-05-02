import 'package:bisleriumbloggers/utilities/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text('Home'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(Uri(path: '/about').toString());
              },
              child: Text('About Page')),
          ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(AppRouteConstants.profileRouteName, params: {
                  'username': 'Akshit Madan',
                  'userid': 'uhfhfhfdghfk'
                });
              },
              child: Text('Profile Page')),
          ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(AppRouteConstants.contactUsRouteName);
              },
              child: Text('ContactUs Page')),
        ],
      ),
    );
  }
}
