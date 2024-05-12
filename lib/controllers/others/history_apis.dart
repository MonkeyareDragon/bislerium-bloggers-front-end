import 'dart:convert';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;

Future<bool> addHistory(String? postId, String? commentId,
    String previousContent, String? updatedContent) async {
  final UserSession session = await getSessionOrThrow();
  final response = await http.post(
    ApiUrlHelper.buildUrl('history/add/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${session.accessToken}',
    },
    body: jsonEncode(<String, dynamic>{
      'postId': postId,
      'commentId': commentId,
      'previousContent': previousContent,
      'updatedContent': updatedContent,
    }),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteHistory(String? id) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.delete(
      ApiUrlHelper.buildUrl('history/delete/?id=$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
