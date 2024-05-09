import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, String>> _historyItems = [
    {
      'date': 'May 9, 2024',
      'original': 'This is original',
      'update': 'Fixed a bug in the login page',
      'tags': '#blog',
    },
    {
      'date': 'May 9, 2024',
      'original': 'This is Test Comment',
      'update': 'Update test comment',
      'tags': '#comment',
    },
    {
      'date': 'May 9, 2024',
      'original': 'This is original',
      'update': 'Very helpfull comment.',
      'tags': '#comment',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: _historyItems.length,
        itemBuilder: (context, index) {
          final item = _historyItems[index];
          return Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Update Date:"),
                          SizedBox(width: 5.0),
                          Text(
                            item['date']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text("Original Content: "),
                          SizedBox(width: 5.0),
                          Text(
                            item['original']!,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: -4.0,
                        children: item['tags']!.split(',').map((tag) {
                          return Chip(
                            label: Text(
                              tag.trim(),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[800],
                              ),
                            ),
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("Update Content:"),
                  ],
                ),
                SizedBox(width: 8.0),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      item['update']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
