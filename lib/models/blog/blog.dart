import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';

class Blog {
  int? voteCount, commentCount;
  String? id, author, createDate, updateDate, title, description, image;

  Blog(
      {this.id,
      this.author,
      this.createDate,
      this.updateDate,
      this.title,
      this.description,
      this.image,
      this.voteCount,
      this.commentCount}) {
    image = UrlUtil.getImageUrl(image!);
  }

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json["id"],
      author: json["author"],
      createDate: json["createDate"],
      updateDate: json["updateDate"],
      image: json["image"],
      voteCount: json["voteCount"],
      commentCount: json["commentCount"],
      title: json["title"],
      description: json["description"],
    );
  }
}
