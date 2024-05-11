import 'dart:convert';

import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/session_manager.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;

Future<bool> updateUserProfile(Map<String, dynamic> body) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.put(
      ApiUrlHelper.buildUrl('api/Account/update?id=${session.userId}'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      String email = body["email"];
      String username = body["username"];

      await SessionManager.updateProfileSession(email, username);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error updating user profile: $e');
    throw Exception('Failed to updating user profile: $e');
  }
}

Future<bool> deleteUser() async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.delete(
      ApiUrlHelper.buildUrl('api/Account?id=${session.userId}'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, the comment was added successfully
      await SessionManager.clearSession();
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
