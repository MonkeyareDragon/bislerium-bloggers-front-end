import 'package:bisleriumbloggers/models/blog/blog.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Blog>> fetchNoTokenBlogsDetails() async {
  try {
    final response = await http.get(
      ApiUrlHelper.buildUrl('post/get-all/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  } catch (e) {
    print('Error fetching blogs: $e');
    throw Exception('Failed to fetch blogs: $e');
  }
}

Future<List<Blog>> fetchRandomBlogsDetails() async {
  try {
    final response = await http.get(
      ApiUrlHelper.buildUrl('post/get-random/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  } catch (e) {
    print('Error fetching blogs: $e');
    throw Exception('Failed to fetch blogs: $e');
  }
}

Future<List<Blog>> fetchPopularBlogsDetails() async {
  try {
    final response = await http.get(
      ApiUrlHelper.buildUrl('post/get-all-sorted-by-popularity/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  } catch (e) {
    print('Error fetching blogs: $e');
    throw Exception('Failed to fetch blogs: $e');
  }
}

Future<List<Blog>> fetchNoRecentBlogsDetails() async {
  try {
    final response = await http.get(
      ApiUrlHelper.buildUrl('post/get-all-recent/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  } catch (e) {
    print('Error fetching blogs: $e');
    throw Exception('Failed to fetch blogs: $e');
  }
}
