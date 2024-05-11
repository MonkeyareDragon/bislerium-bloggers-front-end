import 'package:bisleriumbloggers/models/blog/comment.dart';
import 'dart:convert';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:http/http.dart' as http;
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';

Future<List<Comment>?> fetchCommentsWithReplies(String postId) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.get(
      ApiUrlHelper.buildUrl('post/get-all-comment-details/?postId=$postId'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> data = json.decode(response.body);
      List<Comment> comments = [];

      for (var item in data) {
        // Parse comment data
        Comment comment = Comment(
          commentid: item['commentid'],
          author: item['author'],
          content: item['content'],
          voteCount: item['voteCount'],
          createDate: item['createDate'],
          updateDate: item['updateDate'],
          replyCount: item['replyCount'],
          replies: [],
          showReplies: false,
        );

        // Parse replies data
        List<Reply> replies = [];
        for (var reply in item['replies']) {
          replies.add(Reply(
            replyId: reply['replyId'],
            author: reply['author'],
            content: reply['content'],
            voteCount: reply['voteCount'],
            createDate: reply['createDate'],
            updateDate: reply['updateDate'],
          ));
        }

        // Add replies to comment
        comment.replies = replies;

        // Add comment to list
        comments.add(comment);
      }
      return comments;
    } else {
      throw Exception('Failed to load comments and replies');
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<bool> addCommentOnPost(String postId, String commentText) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.post(
      ApiUrlHelper.buildUrl('comment/add/'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'postId': postId,
        'commentText': commentText,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, the comment was added successfully
      print('Comment added successfully');
      return true;
    } else {
      print('Failed to add comment');
      return false;
    }
  } catch (e) {
    return false;
    // Handle any errors here
  }
}

Future<bool> deleteCommentOnPost(String? id) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.delete(
      ApiUrlHelper.buildUrl('comment/delete/?id=$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, the comment was added successfully
      print('Comment deleted successfully');
      return true;
    } else {
      print('Failed to delete comment');
      return false;
    }
  } catch (e) {
    return false;
    // Handle any errors here
  }
}

Future<bool> updateComment(Map<String, dynamic> body) async {
  try {
    final UserSession session = await getSessionOrThrow();
    final response = await http.put(
      ApiUrlHelper.buildUrl('comment/update/'),
      headers: <String, String>{
        'Authorization': 'Bearer ${session.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception('Failed to updating comment: $e');
  }
}
