class PostSummaryDTO {
  final String postId;
  final String title;
  final DateTime createdAt;
  final int popularity;
  final int commentsCount;

  PostSummaryDTO({
    required this.postId,
    required this.title,
    required this.createdAt,
    required this.popularity,
    required this.commentsCount,
  });

  factory PostSummaryDTO.fromJson(Map<String, dynamic> json) {
    return PostSummaryDTO(
      postId: json['postId'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      popularity: json['popularity'],
      commentsCount: json['commentsCount'],
    );
  }
}
