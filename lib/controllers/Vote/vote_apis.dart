import 'dart:convert';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;

Future<bool> createVote(
    String? postId, String? commentId, String? replyId, int voteType) async {
  final UserSession session = await getSessionOrThrow();
  final response = await http.post(
    ApiUrlHelper.buildUrl('vote/create'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${session.accessToken}',
    },
    body: jsonEncode(<String, dynamic>{
      'userId': session.userId,
      "postId": postId,
      'commentId': commentId,
      'replyId': replyId,
      'voteType': voteType,
    }),
  );
  if (response.statusCode == 200) {
    print("create");
    return true;
  } else {
    throw Exception('Failed to create vote.');
  }
}

Future<bool> removeVote(
    String? postId, String? commentId, String? replyId) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.delete(
      ApiUrlHelper.buildUrl('vote/remove/'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "postId": postId,
        'commentId': commentId,
        'replyId': replyId,
      }),
    );
    if (response.statusCode == 200) {
      print("remove");
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> updateVoteType(
    String? postId, String? commentId, String? replyId, int newVoteType) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.put(
      ApiUrlHelper.buildUrl('vote/update/'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "postId": postId,
        'commentId': commentId,
        'replyId': replyId,
        "voteType": newVoteType
      }),
    );

    if (response.statusCode == 200) {
      print("update");
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
