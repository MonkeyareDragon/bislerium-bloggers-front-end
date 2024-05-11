import 'package:bisleriumbloggers/controllers/User/user_profile_apis.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatefulWidget {
  final String initialUsername;
  final String initialEmail;

  EditProfilePage({
    required this.initialUsername,
    required this.initialEmail,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;

  void _showSnackBarOnPreviousScreen(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: BisleriumColor.kPrimaryColor,
        elevation: 0,
        margin: EdgeInsets.only(
          top: 0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final body = {
                    "email": _emailController.text,
                    "username": _usernameController.text,
                    "role": "Blogger"
                  };
                  bool isSuccess = await updateUserProfile(body);

                  if (isSuccess) {
                    _showSnackBarOnPreviousScreen(
                        context, 'Profile updated successfully');
                    GoRouter.of(context).push(Uri(path: '/profile').toString());
                  } else {
                    _showSnackBarOnPreviousScreen(
                        context, 'Failed to update the profile');
                  }
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
