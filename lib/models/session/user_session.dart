class UserSession {
  final int userId;
  final String accessToken;
  final String email;
  final String username;
  final String role;

  UserSession(
      {required this.userId,
      required this.accessToken,
      required this.email,
      required this.username,
      required this.role});

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
        userId: json['userId'],
        accessToken: json['accessToken'],
        email: json['email'],
        username: json['username'],
        role: json['role']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'accessToken': accessToken,
      'email': email,
      'username': username,
      'role': role
    };
  }
}
