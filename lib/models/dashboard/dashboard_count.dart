class DashboardCounts {
  final int userCount;
  final int postCount;
  final int totalCommentCount;
  final int upvoteCount;
  final int downvoteCount;

  DashboardCounts({
    required this.userCount,
    required this.postCount,
    required this.totalCommentCount,
    required this.upvoteCount,
    required this.downvoteCount,
  });

  factory DashboardCounts.fromJson(Map<String, dynamic> json) {
    return DashboardCounts(
      userCount: json['userCount'],
      postCount: json['postCount'],
      totalCommentCount: json['totalCommentCount'],
      upvoteCount: json['upvoteCount'],
      downvoteCount: json['downvoteCount'],
    );
  }
}
