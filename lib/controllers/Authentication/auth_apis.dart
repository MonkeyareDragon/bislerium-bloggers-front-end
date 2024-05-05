import 'dart:convert';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> login(String email, String password) async {
  print(
    ApiUrlHelper.buildUrl('/api/Account/login'),
  );
  final response = await http.post(
    ApiUrlHelper.buildUrl('api/Account/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  print(
    ApiUrlHelper.buildUrl('/api/Account/login'),
  );
  if (response.statusCode == 200) {
    // Successful login
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(responseData); // Print the response data
    // int userId = responseData['user_id'];
    // String accessToken = responseData['access'];
    // String firstName = responseData['first_name'];
    // String lastName = responseData['last_name'];

    // await SessionManager.saveSession(UserSession(
    //   userId: userId,
    //   accessToken: accessToken,
    //   firstName: firstName,
    //   lastName: lastName,
    // ));

    return {'success': true, 'token': responseData['access']};
  } else {
    print('Error: ${response.statusCode} - ${response.body}');
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
