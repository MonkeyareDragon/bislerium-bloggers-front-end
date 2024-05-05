import 'package:bisleriumbloggers/controllers/Menu/menu_controller.dart'
    as NewsMenuController;
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/helpers/constants.dart';
import 'package:bisleriumbloggers/utilities/helpers/responsive.dart';
import 'package:bisleriumbloggers/utilities/widgets/socal.dart';
import 'package:bisleriumbloggers/utilities/widgets/web_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  final NewsMenuController.MenuController _controller =
      Get.put(NewsMenuController.MenuController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: BisleriumColor.kDarkBlackColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              constraints:
                  BoxConstraints(maxWidth: BisleriumConstant.kMaxWidth),
              padding: EdgeInsets.all(BisleriumConstant.kDefaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _controller.openOrCloseDrawer();
                          },
                        ),
                      SvgPicture.asset("assets/icons/logo.svg"),
                      Spacer(),
                      if (Responsive.isDesktop(context)) WebMenu(),
                      Spacer(),
                      // Socal
                      Socal(),
                    ],
                  ),
                  SizedBox(height: BisleriumConstant.kDefaultPadding * 2),
                  Text(
                    "Welcome to Our Blog",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: BisleriumConstant.kDefaultPadding),
                    child: Text(
                      "Stay updated with the newest design and development stories, case studies, \nand insights shared by DesignDK Team.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        height: 1.5,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "Learn More",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                              width: BisleriumConstant.kDefaultPadding / 2),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (Responsive.isDesktop(context))
                    SizedBox(height: BisleriumConstant.kDefaultPadding),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
