import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/routes/route_config.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          final bool hasValidSession = snapshot.data ?? false;
          return FutureBuilder<bool>(
            future: checkRole(),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                // Show loading indicator while checking the user's role
                return const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else {
                final bool isAdmin = roleSnapshot.data ?? false;
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Bislerium Bloggers',
                  theme: ThemeData(
                    scaffoldBackgroundColor: BisleriumColor.whiteColor,
                  ),
                  routeInformationParser: AppRouter.returnRouter(true, isAdmin)
                      .routeInformationParser,
                  routerDelegate:
                      AppRouter.returnRouter(true, isAdmin).routerDelegate,
                );
              }
            },
          );
        }
      },
    );
  }
}

Future<bool> checkSession() async {
  final UserSession session = await getSessionOrThrow();
  return session.accessToken.isEmpty;
}

Future<bool> checkRole() async {
  final UserSession session = await getSessionOrThrow();
  if (session.role == "Admin") {
    return true;
  } else {
    return false;
  }
}
