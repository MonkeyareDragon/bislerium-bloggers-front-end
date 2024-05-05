import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/routes/route_config.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bislerium Bloggers',
      theme: ThemeData(
        scaffoldBackgroundColor: BisleriumColor.whiteColor,
      ),
      routeInformationParser:
          AppRouter.returnRouter(true).routeInformationParser,
      routerDelegate: AppRouter.returnRouter(true).routerDelegate,
    );
  }
}
