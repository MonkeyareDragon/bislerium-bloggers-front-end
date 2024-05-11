import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyUserId = 'userId';
  static const String _keyAccessToken = 'accessToken';
  static const String _keyemail = 'email';
  static const String _keyusername = 'username';
  static const String _keyrole = 'role';

  static Future<void> saveSession(UserSession session) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUserId, session.userId);
    prefs.setString(_keyAccessToken, session.accessToken);
    prefs.setString(_keyemail, session.email);
    prefs.setString(_keyusername, session.username);
    prefs.setString(_keyrole, session.role);
  }

  static Future<UserSession?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_keyUserId);
    final accessToken = prefs.getString(_keyAccessToken);
    final email = prefs.getString(_keyemail);
    final username = prefs.getString(_keyusername);
    final role = prefs.getString(_keyrole);

    if (userId != null &&
        accessToken != null &&
        email != null &&
        username != null &&
        role != null) {
      return UserSession(
        userId: userId,
        accessToken: accessToken,
        email: email,
        username: username,
        role: role,
      );
    }

    return null;
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyUserId);
    prefs.remove(_keyAccessToken);
    prefs.remove(_keyemail);
    prefs.remove(_keyusername);
    prefs.remove(_keyrole);
  }

  static Future<void> updateProfileSession(
      String email, String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyemail);
    prefs.remove(_keyusername);
    prefs.setString(_keyemail, email);
    prefs.setString(_keyusername, username);
  }
}
