import 'package:bisleriumbloggers/controllers/User/user_profile_apis.dart';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePage createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    String username = session?.username ?? 'Loading..';
    String email = session?.email ?? 'Loading..';
    String userType = session?.role ?? 'Loading..';

    return Theme(
      data: ThemeData.dark(), // Apply dark theme
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Username:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    username,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    email,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'User Type:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    userType,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push(Uri(
                        path: '/profile/edit/$username/$email',
                      ).toString());
                    },
                    child: Text('Edit'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Show delete confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text(
                                'Are you sure you want to delete your account?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  bool isSuccess = await deleteUser();
                                  if (isSuccess) {
                                    Navigator.of(context).pop();
                                    GoRouter.of(context)
                                        .push(Uri(path: '/login').toString());
                                  }
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      backgroundColor: Colors.red, // Change button color to red
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
