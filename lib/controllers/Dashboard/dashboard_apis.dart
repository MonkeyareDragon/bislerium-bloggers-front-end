import 'package:bisleriumbloggers/models/dashboard/dashboard_count.dart';
import 'package:bisleriumbloggers/models/dashboard/dashboard_post.dart';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<DashboardCounts> fetchCountDashboard() async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.get(
      ApiUrlHelper.buildUrl('dashboard/all-time-counts/'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DashboardCounts.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load blogs');
    }
  } catch (e) {
    throw Exception('Failed to fetch blogs: $e');
  }
}

Future<DashboardCounts> fetchCountOnChosenDateDashboard(
    DateTime startDate, DateTime endDate) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.get(
      ApiUrlHelper.buildUrl(
          'dashboard/choosen-time-counts?startDate=$startDate&endDate=$endDate'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DashboardCounts.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load blogs');
    }
  } catch (e) {
    throw Exception('Failed to fetch blogs: $e');
  }
}

Future<List<PostSummaryDTO>> fetchPopularPostsAllTime() async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.get(
      ApiUrlHelper.buildUrl('dashboard/popular-posts-all-time'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PostSummaryDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular posts');
    }
  } catch (e) {
    throw Exception('Failed to load popular posts: $e');
  }
}

Future<List<PostSummaryDTO>> getPopularPostsChosenMonth(int month) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.get(
      ApiUrlHelper.buildUrl(
          'dashboard/popular-posts-chosen-month/?month=$month'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<PostSummaryDTO> popularPosts =
          responseData.map((data) => PostSummaryDTO.fromJson(data)).toList();
      return popularPosts;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

Future<List<UserPopularityDto>> fetchPopularBloggerAllTime() async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.get(
      ApiUrlHelper.buildUrl('dashboard/popular-bloggers-all-time'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => UserPopularityDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular blogger');
    }
  } catch (e) {
    throw Exception('Failed to load popular blogger: $e');
  }
}

Future<List<UserPopularityDto>> getPopularBloggersChosenMonth(int month) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.get(
      ApiUrlHelper.buildUrl(
          'dashboard/popular-bloggers-chosen-month/?month=$month'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => UserPopularityDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular blogger monthly');
    }
  } catch (e) {
    throw Exception('Failed to load popular blogger monthly: $e');
  }
}
