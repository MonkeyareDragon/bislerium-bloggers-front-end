import 'package:bisleriumbloggers/controllers/others/notification_apis.dart';
import 'package:bisleriumbloggers/models/others/notification.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<UserNotification> _notifications = [];

  @override
  void initState() {
    super.initState();
    loginAuthentication();
    _loadNotifications();
  }

  Future<void> loginAuthentication() async {
    try {
      final session = await getSessionOrThrow();
      if (session.accessToken.isEmpty) {
        GoRouter.of(context).push(Uri(path: '/login').toString());
      }
    } catch (e) {
      GoRouter.of(context).push(Uri(path: '/login').toString());
    }
  }

  Future<void> _loadNotifications() async {
    try {
      List<UserNotification> notifications = await getNotifications();
      setState(() {
        _notifications = notifications;
      });
    } catch (e) {}
  }

  Future<void> deleteUserNotification(String? commentid) async {
    bool result = await deleteNotification(commentid);
    if (result) {
      _loadNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    notification.postImage!,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMM d, yyyy hh a')
                          .format(DateTime.parse(notification.createdAt!)),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      notification.note!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteUserNotification(notification.notificationId);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
