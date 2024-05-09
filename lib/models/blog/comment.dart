class Comment {
  final String? commentid;
  final String? author;
  final String? content;
  final int? voteCount;
  final String? createDate;
  final String? updateDate;
  final int? replyCount;
  List<Reply>? replies;
  bool showReplies;

  Comment({
    this.commentid,
    this.author,
    this.content,
    this.voteCount,
    this.createDate,
    this.updateDate,
    this.replyCount,
    this.replies,
    this.showReplies = false,
  });
}

class Reply {
  final String? replyId;
  final String? author;
  final String? content;
  final int? voteCount;
  final String? createDate;
  final String? updateDate;

  Reply({
    this.replyId,
    this.author,
    this.content,
    this.voteCount,
    this.createDate,
    this.updateDate,
  });
}
