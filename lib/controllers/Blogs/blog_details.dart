import 'dart:convert';
import 'package:bisleriumbloggers/models/blog/blog.dart';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:http/http.dart' as http;
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';

Future<Blog?> getPostById(String id) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.get(
      ApiUrlHelper.buildUrl('post/get-by-id?id=$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response into a Blog object
      return Blog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
