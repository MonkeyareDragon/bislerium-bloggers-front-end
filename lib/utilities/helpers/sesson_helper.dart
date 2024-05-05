import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/session_manager.dart';

Future<UserSession> getSessionOrThrow() async {
  final UserSession? session = await SessionManager.getSession();
  if (session == null) {
    throw Exception('No session found');
  }
  return session;
}
