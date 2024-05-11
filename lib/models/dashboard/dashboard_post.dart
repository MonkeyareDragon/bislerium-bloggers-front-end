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

class UserPopularityDto {
  final String userId;
  final String username;
  final DateTime createdAt;
  final double popularityScore;
  final int totalPosts;

  UserPopularityDto({
    required this.userId,
    required this.username,
    required this.createdAt,
    required this.popularityScore,
    required this.totalPosts,
  });

  factory UserPopularityDto.fromJson(Map<String, dynamic> json) {
    return UserPopularityDto(
      userId: json['userId'],
      username: json['username'],
      createdAt: DateTime.parse(json['createdAt']),
      popularityScore: json['popularityScore'],
      totalPosts: json['totalPosts'],
    );
  }
}
