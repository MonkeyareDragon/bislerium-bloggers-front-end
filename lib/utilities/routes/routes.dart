import 'package:bisleriumbloggers/screens/dashboard.dart';
import 'package:bisleriumbloggers/screens/details.dart';
import 'package:bisleriumbloggers/screens/login.dart';
import 'package:bisleriumbloggers/utilities/routes/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const loginRoute = "/";
  static const DashboardRoute = "/Dashboard";
  static const DetailsRoute = "/Details";

  static final GoRouter routes = GoRouter(routes: <GoRoute>[
    GoRoute(
      path: loginRoute,
      builder: (BuildContext context, state) => const LoginView(),
    ),
    GoRoute(
      path: DashboardRoute,
      builder: (_, state) => const DashboardView(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: DetailsRoute,
      builder: (_, state) => const DetailsView(),
      redirect: (context, state) => _redirect(context),
    ),
  ]);

  static String? _redirect(BuildContext context) {
    return AuthService.authenticated ? null : context.namedLocation("/");
  }
}
