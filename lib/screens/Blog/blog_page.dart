import 'package:bisleriumbloggers/controllers/Menu/menu_controller.dart'
    as news_menu_controller;
import 'package:bisleriumbloggers/screens/Blog/home_page.dart';
import 'package:bisleriumbloggers/utilities/helpers/constants.dart';
import 'package:bisleriumbloggers/utilities/widgets/header.dart';
import 'package:bisleriumbloggers/utilities/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPage();
}

class _BlogPage extends State<BlogPage> {
  final news_menu_controller.MenuController _controller =
      Get.put(news_menu_controller.MenuController());
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _controller.scaffoldkey,
        drawer: SideMenu(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Header(),
            Container(
              padding: const EdgeInsets.all(BisleriumConstant.kDefaultPadding),
              constraints:
                  const BoxConstraints(maxWidth: BisleriumConstant.kMaxWidth),
              child: const SafeArea(child: HomeScreen()),
            )
          ],
        )));
  }
}
