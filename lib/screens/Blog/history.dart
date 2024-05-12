import 'dart:convert';
import 'package:bisleriumbloggers/controllers/others/history_apis.dart';
import 'package:intl/intl.dart';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, String>> _historyItems = [];

  Future<void> fetchHistoryData() async {
    final UserSession session = await getSessionOrThrow();
    final response = await http
        .get(ApiUrlHelper.buildUrl('history/get/'), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${session.accessToken}',
    });
    if (response.statusCode == 200) {
      final List<dynamic> historyData = jsonDecode(response.body);
      setState(() {
        _historyItems = historyData.map<Map<String, String>>((data) {
          final postId = data['postId'];
          final commentId = data['commentId'];
          final tagName = postId != null
              ? 'Post'
              : commentId != null
                  ? 'Comment'
                  : '';
          final formattedDate = DateFormat('MMM d, yyyy hh a')
              .format(DateTime.parse(data['createdAt']));
          return {
            'id': data["historyID"],
            'date': formattedDate,
            'original': data['previousContent'],
            'update': data['updatedContent'],
            'tags': '#' + tagName,
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load history data');
    }
  }

  Future<void> deleteBlogComment(String? commentid) async {
    bool result = await deleteHistory(commentid);
    if (result) {
      fetchHistoryData();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHistoryData();
  }

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
                      Row(
                        children: [
                          Text("Update Content: "),
                          SizedBox(width: 5.0),
                          Text(
                            item['update']!,
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
                        children: [
                          ...item['tags']!.split(',').map((tag) {
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
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              print(item['id']!);
                              deleteBlogComment(item['id']!);
                            },
                          ),
                        ],
                      ),
                    ],
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
