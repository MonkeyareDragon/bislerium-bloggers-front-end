import 'package:flutter/material.dart';

class AddAdminPage extends StatefulWidget {
  @override
  _AddAdminPageState createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  final _formKey = GlobalKey<FormState>();
  String _user = '';
  String _email = '';
  String _password = '';

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
                onSaved: (value) => _user = value!,
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
                decoration: InputDecoration(
                  hintText: 'Enter email address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  // Add email validation logic here...
                  return null;
                },
                onSaved: (value) => _email = value!,
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
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  // Add password validation logic here...
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Implement add admin logic here
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