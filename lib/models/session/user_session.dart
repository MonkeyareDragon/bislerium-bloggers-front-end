class UserSession {
  final String userId;
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
        userId: json['id'],
        accessToken: json['token'],
        email: json['email'],
        username: json['name'],
        role: json['role']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'token': accessToken,
      'email': email,
      'name': username,
      'role': role
    };
  }
}
