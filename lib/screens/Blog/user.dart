import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String username = 'kabin';
    String email = 'kabin123@gmail.com';
    String userType = 'Blogger';
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
                                onPressed: () {
                                  // Implement delete functionality here
                                  // Once deletion is complete, you can navigate back to previous screen or perform any other action
                                  Navigator.of(context)
                                      .pop(); // Closethe dialog
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
