import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/helpers/constants.dart';
import 'package:bisleriumbloggers/utilities/helpers/responsive.dart';
import 'package:bisleriumbloggers/utilities/helpers/session_manager.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Socal extends StatefulWidget {
  const Socal({super.key});

  @override
  State<Socal> createState() => _Socal();
}

class _Socal extends State<Socal> {
  UserSession? session;

  @override
  void initState() {
    super.initState();
    _fetchSession();
  }

  Future<void> _fetchSession() async {
    try {
      session = await getSessionOrThrow();
      setState(() {});
    } catch (e) {
      print('Error fetching session: $e');
    }
  }

  Future<void> _handleLogout() async {
    await SessionManager.clearSession();
    GoRouter.of(context).push(Uri(path: '/login').toString());
  }

  @override
  Widget build(BuildContext context) {
    String isToken = session?.accessToken ?? '';
    return Row(
      children: [
        if (!Responsive.isMobile(context))
          SvgPicture.asset("assets/icons/behance-alt.svg"),
        if (!Responsive.isMobile(context))
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: BisleriumConstant.kDefaultPadding / 2),
            child: SvgPicture.asset("assets/icons/feather_dribbble.svg"),
          ),
        if (!Responsive.isMobile(context))
          SvgPicture.asset("assets/icons/feather_twitter.svg"),
        const SizedBox(width: BisleriumConstant.kDefaultPadding),
        ElevatedButton(
          onPressed: () {
            if (isToken.isNotEmpty) {
              _handleLogout();
            } else {
              GoRouter.of(context).push(Uri(path: '/login').toString());
            }
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: BisleriumConstant.kDefaultPadding * 1.5,
              vertical: BisleriumConstant.kDefaultPadding /
                  (Responsive.isDesktop(context) ? 1 : 2),
            ),
            backgroundColor: BisleriumColor.kPrimaryColor,
          ),
          child: Text(
            isToken.isNotEmpty ? "Log Out" : "Log In",
            style: const TextStyle(color: BisleriumColor.whiteColor),
          ),
        ),
      ],
    );
  }
}
