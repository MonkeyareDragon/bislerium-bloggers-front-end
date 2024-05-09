import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, dynamic>> _notifications = [
    {
      'image': 'https://picsum.photos/id/1015/100/100',
      'date': 'Today, 10:00 AM',
      'note': 'This is my first notification!',
    },
    {
      'image': 'https://picsum.photos/id/1016/100/100',
      'date': 'Yesterday, 5:00 PM',
      'note': 'This is my second notification!',
    },
    // Add more notifications here...
  ];

  NotificationPage({Key? key});

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
                    notification['image']!,
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
                      notification['date']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      notification['note']!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
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