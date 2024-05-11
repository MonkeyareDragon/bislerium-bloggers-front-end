import 'package:bisleriumbloggers/controllers/Authentication/auth_apis.dart';
import 'package:bisleriumbloggers/screens/Authentication/login_page.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAdminPage extends StatefulWidget {
  @override
  _AddAdminPageState createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final session = await getSessionOrThrow();
      if (session.role != 'Admin') {
        GoRouter.of(context).push(Uri(path: '/access-denial').toString());
      } else {}
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter user name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();
                      final String username = usernameController.text.trim();

                      bool isStatus = await registerAdmin(
                          username, email, password, password);
                      if (isStatus) {
                        GoRouter.of(context).push(
                            Uri(path: '/admin-create/success').toString());
                      } else {}
                    }
                  },
                  child: Text('Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
