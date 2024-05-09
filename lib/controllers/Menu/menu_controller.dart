import 'package:bisleriumbloggers/utilities/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static void navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).push(Uri(path: '/').toString());
        break;
      case 1:
        GoRouter.of(context).pushNamed(AppRouteConstants.dashboardRouteName);
        break;
      case 2:
        GoRouter.of(context).push(Uri(path: '/notification').toString());
        break;
      case 3:
        GoRouter.of(context).push(Uri(path: '/history').toString());
        break;
      case 4:
        GoRouter.of(context).push(Uri(path: '/profile').toString());
        break;
    }
  }
}

class MenuController extends GetxController {
  RxInt _selectedIndex = 0.obs;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int get selectedIndex => _selectedIndex.value;
  List<String> get menuItems =>
      ["Blog", "Dashboard", "Notification", "History", "Profile", "About Us"];
  GlobalKey<ScaffoldState> get scaffoldkey => _scaffoldKey;

  void openOrCloseDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setMenuIndex(int index) {
    _selectedIndex.value = index;
  }

  void navigateToPage(BuildContext context, int index) {
    NavigationService.navigateToPage(context, index);
  }
}
