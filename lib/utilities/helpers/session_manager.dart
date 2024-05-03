// import 'package:bisleriumbloggers/models/session/user_session.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SessionManager {
//   static const String _keyUserId = 'userId';
//   static const String _keyAccessToken = 'accessToken';
//   static const String _keyemail = 'email';
//   static const String _keyusername = 'username';
//   static const String _keyrole = 'role';

//   static Future<void> saveSession(UserSession session) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setInt(_keyUserId, session.userId);
//     prefs.setString(_keyAccessToken, session.accessToken);
//   }

//   static Future<UserSession?> getSession() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getInt(_keyUserId);
//     final accessToken = prefs.getString(_keyAccessToken);
//     final firstName = prefs.getString(_keyFirstName);
//     final lastName = prefs.getString(_keyLastName);

//     if (userId != null &&
//         accessToken != null &&
//         firstName != null &&
//         lastName != null) {
//       return UserSession(userId: userId, accessToken: accessToken);
//     }

//     return null;
//   }

//   static Future<void> clearSession() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(_keyUserId);
//     prefs.remove(_keyAccessToken);
//     prefs.remove(_keyFirstName);
//     prefs.remove(_keyLastName);
//   }
// }
