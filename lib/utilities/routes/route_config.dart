import 'package:bisleriumbloggers/screens/Authentication/login_page.dart';
import 'package:bisleriumbloggers/screens/Authentication/set_username_page.dart';
import 'package:bisleriumbloggers/screens/Authentication/signup_page.dart';
import 'package:bisleriumbloggers/screens/test/about.dart';
import 'package:bisleriumbloggers/screens/test/contact_us.dart';
import 'package:bisleriumbloggers/screens/test/error_page.dart';
import 'package:bisleriumbloggers/screens/test/home.dart';
import 'package:bisleriumbloggers/screens/test/profile.dart';
import 'package:bisleriumbloggers/utilities/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: AppRouteConstants.homeRouteName,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(child: Home());
          },
        ),
        GoRoute(
          name: AppRouteConstants.loginRouteName,
          path: '/login',
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginPage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.registerRouteName,
          path: '/register/:username',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: RegisterPage(
              username: state.params['username']!,
            ));
          },
        ),
        GoRoute(
          name: AppRouteConstants.usernameRouteName,
          path: '/username',
          pageBuilder: (context, state) {
            return const MaterialPage(child: SetUsernamePage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.profileRouteName,
          path: '/profile/:username/:userid',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: Profile(
              userid: state.params['userid']!,
              username: state.params['username']!,
            ));
          },
        ),
        GoRoute(
          name: AppRouteConstants.aboutRouteName,
          path: '/about',
          pageBuilder: (context, state) {
            return MaterialPage(child: About());
          },
        ),
        GoRoute(
          name: AppRouteConstants.contactUsRouteName,
          path: '/contact_us',
          pageBuilder: (context, state) {
            return MaterialPage(child: ContactUS());
          },
        )
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(child: ErrorPage());
      },
      redirect: (context, state) {
        if (!isAuth &&
            state.location
                .startsWith('/${AppRouteConstants.profileRouteName}')) {
          return context.namedLocation(AppRouteConstants.loginRouteName);
        } else {
          return null;
        }
      },
    );
    return router;
  }
}
