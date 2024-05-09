import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, dynamic>> _notifications = [
    {
      'image':
          'https://ideausher.com/wp-content/uploads/2023/11/Augmented-reality-in-the-retail-industry-use-cases-and-real-life-examples-1.webp',
      'date': 'Today, 8:28 PM',
      'note': 'TestUser have comment on your blog!',
    },
    {
      'image':
          'https://ideausher.com/wp-content/uploads/2023/11/Augmented-reality-in-the-retail-industry-use-cases-and-real-life-examples-1.webp',
      'date': 'Today, 8:20 PM',
      'note': 'TestUser have like on your blog!',
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
