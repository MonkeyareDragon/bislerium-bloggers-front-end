import 'package:bisleriumbloggers/models/blog/blog.dart';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Blog>> createNewBlog(Map<String, dynamic> body) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.post(
      ApiUrlHelper.buildUrl('post/add/'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Failed to create blogs');
    }
  } catch (e) {
    print('Error create blogs: $e');
    throw Exception('Failed to create blogs: $e');
  }
}
