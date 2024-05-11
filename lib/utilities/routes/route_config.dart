import 'package:bisleriumbloggers/screens/Admin/access_denial%20_page.dart';
import 'package:bisleriumbloggers/screens/Admin/add_admin.dart';
import 'package:bisleriumbloggers/screens/Admin/admin_page.dart';
import 'package:bisleriumbloggers/screens/Admin/successfull_admin_create.dart';
import 'package:bisleriumbloggers/screens/Authentication/login_page.dart';
import 'package:bisleriumbloggers/screens/Authentication/set_username_page.dart';
import 'package:bisleriumbloggers/screens/Authentication/signup_page.dart';
import 'package:bisleriumbloggers/screens/Blog/add_post.dart';
import 'package:bisleriumbloggers/screens/Blog/blog_details_page.dart';
import 'package:bisleriumbloggers/screens/Blog/blog_page.dart';
import 'package:bisleriumbloggers/screens/User/edit_profile_page.dart';
import 'package:bisleriumbloggers/screens/Blog/history.dart';
import 'package:bisleriumbloggers/screens/Blog/notification_page.dart';
import 'package:bisleriumbloggers/screens/Blog/password_change.dart';
import 'package:bisleriumbloggers/screens/User/user_profile.dart';
import 'package:bisleriumbloggers/screens/test/about.dart';
import 'package:bisleriumbloggers/screens/test/contact_us.dart';
import 'package:bisleriumbloggers/screens/test/error_page.dart';
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
            return const MaterialPage(child: BlogPage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.blogDetailsRouteName,
          path: '/details/:blogid',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: BlogDetailsPage(
              blogid: state.params['blogid']!,
            ));
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
          name: AppRouteConstants.submitRouteName,
          path: '/submit',
          pageBuilder: (context, state) {
            return const MaterialPage(child: SubmitPost());
          },
        ),
        GoRoute(
          name: AppRouteConstants.dashboardRouteName,
          path: '/dashboard',
          pageBuilder: (context, state) {
            return const MaterialPage(child: AdminPage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.addAdminRouteName,
          path: '/addAdmin',
          pageBuilder: (context, state) {
            return MaterialPage(child: AddAdminPage());
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
          name: AppRouteConstants.notificationRouteName,
          path: '/notification',
          pageBuilder: (context, state) {
            return MaterialPage(child: NotificationPage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.historyRouteName,
          path: '/history',
          pageBuilder: (context, state) {
            return MaterialPage(child: HistoryPage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.passwordChangeRouteName,
          path: '/password-change',
          pageBuilder: (context, state) {
            return MaterialPage(child: PasswordChangePage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.userProfileRouteName,
          path: '/profile',
          pageBuilder: (context, state) {
            return MaterialPage(child: UserProfilePage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.editUserProfileRouteName,
          path: '/profile/edit/:username/:email',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: EditProfilePage(
                    initialUsername: state.params['username']!,
                    initialEmail: state.params['email']!));
          },
        ),
        GoRoute(
          name: AppRouteConstants.accessdenialRouteName,
          path: '/access-denial',
          pageBuilder: (context, state) {
            return MaterialPage(child: AccessDenialPage());
          },
        ),
        GoRoute(
          name: AppRouteConstants.addAdminSuccessRouteName,
          path: '/admin-create/success',
          pageBuilder: (context, state) {
            return MaterialPage(child: SuccessAdminCreationPage());
          },
        ),
        //Test
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
    );
    return router;
  }
}
