import 'package:bisleriumbloggers/utilities/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;

  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bislerium Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppRoutes.routes,
    );
  }
}
