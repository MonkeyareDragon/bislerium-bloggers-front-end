import 'dart:convert';
import 'package:bisleriumbloggers/models/others/notification.dart';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;

Future<bool> addNotification(String? postId, String? notificationNote) async {
  final UserSession session = await getSessionOrThrow();
  final response = await http.post(
    ApiUrlHelper.buildUrl('notification/add/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${session.accessToken}',
    },
    body: jsonEncode(<String, dynamic>{
      'postId': postId,
      'notificationNote': notificationNote
    }),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteNotification(String? id) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.delete(
      ApiUrlHelper.buildUrl('notification/delete/?id=$id'),
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

Future<List<UserNotification>> getNotifications() async {
  final UserSession session = await getSessionOrThrow();
  final response = await http.get(
    ApiUrlHelper.buildUrl('notification/get/'),
    headers: <String, String>{
      'Authorization': 'Bearer ${session.accessToken}',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(response.body);
    List<UserNotification> notifications =
        jsonResponse.map((model) => UserNotification.fromJson(model)).toList();

    return notifications;
  } else {
    throw Exception('Failed to load notifications');
  }
}
