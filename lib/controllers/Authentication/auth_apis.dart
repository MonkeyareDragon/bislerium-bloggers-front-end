import 'dart:convert';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/session_manager.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> login(
    String username, String email, String password) async {
  final response = await http.post(
    ApiUrlHelper.buildUrl('api/Account/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      "username": username
    }),
  );
  if (response.statusCode == 200) {
    // Successful login
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(responseData); // Print the response data
    String userId = responseData['id'];
    String accessToken = responseData['token'];
    String email = responseData['email'];
    String username = responseData['name'];
    String role = responseData['role'];

    await SessionManager.saveSession(UserSession(
        userId: userId,
        accessToken: accessToken,
        email: email,
        username: username,
        role: role));

    return {'success': true, 'token': responseData['access']};
  } else {
    return {'success': false, 'error': response.body};
  }
}

Future<Map<String, dynamic>> register(String username, String email,
    String password, String confirmPassword) async {
  final response = await http.post(
    ApiUrlHelper.buildUrl('api/Account/register'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'username': username,
      'role': "Blogger",
    }),
  );

  if (response.statusCode == 200) {
    return {'success': true, "detail": "Verification email sent."};
  } else {
    print('Error: ${response.statusCode} - ${response.body}');
    return {'success': false, 'error': '${response.body}'};
  }
}
