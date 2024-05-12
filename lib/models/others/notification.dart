import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';

class UserNotification {
  String? notificationId;
  String? userId;
  String? postId;
  String? note;
  String? createdAt;
  String? postImage;

  UserNotification(
      {this.notificationId,
      this.userId,
      this.postId,
      this.note,
      this.createdAt,
      this.postImage}) {
    postImage = UrlUtil.getImageUrl(postImage!);
  }

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      notificationId: json["notificationId"],
      userId: json["userId"],
      postId: json["postId"],
      note: json["note"],
      createdAt: json["createdAt"],
      postImage: json["postImage"],
    );
  }
}
