import 'dart:typed_data';

import 'package:bisleriumbloggers/controllers/Blogs/blog_comment_api.dart';
import 'package:bisleriumbloggers/controllers/Blogs/blog_details.dart';
import 'package:bisleriumbloggers/controllers/Menu/menu_controller.dart'
    as news_menu_controller;
import 'package:bisleriumbloggers/controllers/others/history_apis.dart';
import 'package:bisleriumbloggers/models/blog/blog.dart';
import 'package:bisleriumbloggers/models/blog/comment.dart';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/screens/Blog/update_post.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/helpers/constants.dart';
import 'package:bisleriumbloggers/utilities/helpers/responsive.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:bisleriumbloggers/utilities/widgets/side_menu.dart';
import 'package:bisleriumbloggers/utilities/widgets/socal.dart';
import 'package:bisleriumbloggers/utilities/widgets/web_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class BlogDetailsPage extends StatefulWidget {
  final String blogid;
  const BlogDetailsPage({
    Key? key,
    required this.blogid,
  }) : super(key: key);

  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPage();
}

class _BlogDetailsPage extends State<BlogDetailsPage> {
  final news_menu_controller.MenuController _controller =
      Get.put(news_menu_controller.MenuController());
  bool liked = false;
  bool disliked = false;
  Blog? _postData;
  List<Comment> comments = [];
  final TextEditingController _commentContentController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPostData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Uint8List?> _getImageData(String? imageUrl) async {
    try {
      // Fetch image bytes from URL
      final response = await http.get(Uri.parse(imageUrl!));

      if (response.statusCode == 200) {
        // Convert image bytes to Uint8List
        return response.bodyBytes;
      } else {
        // Image fetch failed, return null
        return null;
      }
    } catch (e) {
      // Error fetching image, return null
      print('Error fetching image: $e');
      return null;
    }
  }

  Future<void> _fetchPostData() async {
    final blogId = widget.blogid;
    final postData = await getPostById(blogId);
    print(postData?.author);
    setState(() {
      _postData = postData;
    });

    final fetchedComments = await fetchCommentsWithReplies(blogId);
    if (fetchedComments != null) {
      setState(() {
        comments = fetchedComments;
      });
    }
  }

  Future<void> postBlogComment(String postId, String commentText) async {
    bool result = await addCommentOnPost(postId, commentText);
    if (result) {
      _fetchPostData();
    }
  }

  Future<void> deleteBlogComment(String? commentid) async {
    bool result = await deleteCommentOnPost(commentid);
    if (result) {
      _fetchPostData();
    }
  }

  Future<String> getCurrentUsername() async {
    final UserSession session = await getSessionOrThrow();
    return session.username;
  }

  void _showSnackBarOnPreviousScreen(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: BisleriumColor.kPrimaryColor,
        elevation: 0,
        margin: EdgeInsets.only(
          top: 0,
        ),
      ),
    );
  }

  void _showUpdateCommentPopup(
      String commentId, String initialComment, Function(String) onSave) {
    late TextEditingController updateCommentController;
    updateCommentController = TextEditingController(text: initialComment);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Comment'),
          content: TextFormField(
            onChanged: onSave,
            decoration: InputDecoration(
              hintText: 'Enter your updated comment...',
            ),
            controller: updateCommentController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final body = {
                  "commentId": commentId,
                  "commentText": updateCommentController.text
                };
                print(body);
                bool isSuccess = await updateComment(body);

                if (isSuccess) {
                  bool success = await addHistory(null, commentId,
                      initialComment, updateCommentController.text);
                  if (success)
                    _showSnackBarOnPreviousScreen(
                        context, 'Comment updated successfully');
                  _fetchPostData();
                } else {
                  _showSnackBarOnPreviousScreen(
                      context, 'Comment to update the profile');
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldkey,
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: BisleriumColor.kDarkBlackColor,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      constraints:
                          BoxConstraints(maxWidth: BisleriumConstant.kMaxWidth),
                      padding:
                          EdgeInsets.all(BisleriumConstant.kDefaultPadding),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if (!Responsive.isDesktop(context))
                                IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _controller.openOrCloseDrawer();
                                  },
                                ),
                              SvgPicture.asset("assets/icons/logo.svg"),
                              Spacer(),
                              if (Responsive.isDesktop(context)) WebMenu(),
                              Spacer(),
                              // Socal
                              Socal(),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(BisleriumConstant.kDefaultPadding),
              constraints:
                  const BoxConstraints(maxWidth: BisleriumConstant.kMaxWidth),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: BisleriumConstant.kDefaultPadding),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.78,
                        child: Image.network(_postData?.image ??
                            'https://media.istockphoto.com/id/1396814518/vector/image-coming-soon-no-photo-no-thumbnail-image-available-vector-illustration.jpg?s=612x612&w=0&k=20&c=hnh2OZgQGhf0b46-J2z7aHbIWwq8HNlSDaNp2wn_iko='),
                      ),
                      Container(
                        padding:
                            EdgeInsets.all(BisleriumConstant.kDefaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _postData?.author ?? 'Unknown',
                                  style: TextStyle(
                                    color: BisleriumColor.kDarkBlackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    width: BisleriumConstant.kDefaultPadding),
                                Text(
                                  _postData?.createDate ?? 'Unknown',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: BisleriumConstant.kDefaultPadding),
                              child: Text(
                                _postData?.title ?? 'No Title',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize:
                                      Responsive.isDesktop(context) ? 32 : 24,
                                  fontFamily: "Raleway",
                                  color: BisleriumColor.kDarkBlackColor,
                                  height: 1.3,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            FutureBuilder<String>(
                              future: getCurrentUsername(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  final username = snapshot.data;
                                  return Column(
                                    children: [
                                      if (username == _postData?.author)
                                        Row(
                                          children: [
                                            // Edit Button
                                            ElevatedButton(
                                              onPressed: () async {
                                                Uint8List? imageData =
                                                    await _getImageData(
                                                        _postData?.image);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdatePost(
                                                      blogid: _postData?.id,
                                                      initialTitle:
                                                          _postData?.title,
                                                      initialContent: _postData
                                                          ?.description,
                                                      initialImageData:
                                                          imageData, // Provide initial image data if available
                                                    ),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .white10, // Change color as needed
                                              ),
                                              child: Text('Edit'),
                                            ),
                                            SizedBox(width: 10),
                                            // Delete Button
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text('Confirmation'),
                                                      content: Text(
                                                          'Are you sure you want to delete your post?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            bool isSuccess =
                                                                await deleteBlogPost(
                                                                    _postData
                                                                        ?.id);
                                                            if (isSuccess) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              GoRouter.of(
                                                                      context)
                                                                  .push(Uri(
                                                                          path:
                                                                              '/')
                                                                      .toString());
                                                            }
                                                          },
                                                          child: Text('Delete'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .red, // Change color as needed
                                              ),
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        ),
                                    ],
                                  );
                                } else {
                                  return CircularProgressIndicator(); // Placeholder while fetching username
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              _postData?.description ?? 'No Description',
                              maxLines: 4,
                              style: TextStyle(height: 1.5),
                            ),
                            SizedBox(height: BisleriumConstant.kDefaultPadding),
                            Row(
                              children: [
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        liked = !liked;
                                        if (liked) {
                                          _postData?.voteCount =
                                              (_postData?.voteCount ?? 0) + 1;
                                          if (disliked) {
                                            _postData?.voteCount =
                                                (_postData?.voteCount ?? 0) + 1;
                                            disliked = false;
                                          }
                                        } else {
                                          _postData?.voteCount =
                                              (_postData?.voteCount ?? 0) - 1;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.thumb_up_sharp),
                                    color: liked
                                        ? BisleriumColor.kPrimaryColor
                                        : BisleriumColor.backgroundColor),
                                Text('${_postData?.voteCount ?? 0}'),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        disliked = !disliked;
                                        if (disliked) {
                                          _postData?.voteCount =
                                              (_postData?.voteCount ?? 0) - 1;
                                          if (liked) {
                                            _postData?.voteCount =
                                                (_postData?.voteCount ?? 0) - 1;
                                            liked = false;
                                          }
                                        } else {
                                          _postData?.voteCount =
                                              (_postData?.voteCount ?? 0) + 1;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.thumb_down_sharp),
                                    color: disliked
                                        ? BisleriumColor.kPrimaryColor
                                        : BisleriumColor.backgroundColor),
                                IconButton(
                                  icon: SvgPicture.asset(
                                      "assets/icons/feather_message-square.svg"),
                                  onPressed: () {},
                                ),
                                Text('${_postData?.commentCount ?? 0}'),
                              ],
                            ),
                            // Add Comment Section
                            Container(
                              padding: const EdgeInsets.all(
                                  BisleriumConstant.kDefaultPadding),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Add a Comment',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          BisleriumConstant.kDefaultPadding),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _commentContentController,
                                          decoration: InputDecoration(
                                            hintText:
                                                'Write your comment here...',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          String blogId = widget.blogid;
                                          String commentContext =
                                              _commentContentController.text;

                                          postBlogComment(
                                              blogId, commentContext);
                                          _commentContentController.clear();
                                        },
                                        child: Text('Comment'),
                                      ),
                                      SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () {
                                          // Handle cancel button press
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          BisleriumConstant.kDefaultPadding),
                                ],
                              ),
                            ),

                            // Existing Comment Section
                            Container(
                              padding: const EdgeInsets.all(
                                  BisleriumConstant.kDefaultPadding),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Comments (${comments.length})',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          BisleriumConstant.kDefaultPadding),
                                  // Iterate over demoComments and display them
                                  Column(
                                    children: comments.map((comment) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                comment.author ?? 'Unknown',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                comment.createDate ?? 'Unknown',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _showUpdateCommentPopup(
                                                  comment.commentid ?? '',
                                                  comment.content ?? '',
                                                  (String updatedComment) {
                                                // Handle saving the updated comment
                                                // For example, you can call a function to update the comment in the database
                                              });
                                            },
                                            child: Text(comment.content ?? ''),
                                          ),

                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  // Handle upvote button press
                                                },
                                                icon:
                                                    Icon(Icons.thumb_up_sharp),
                                              ),
                                              Text('${comment.voteCount ?? 0}'),
                                              IconButton(
                                                onPressed: () {
                                                  // Handle downvote button press
                                                },
                                                icon: Icon(
                                                    Icons.thumb_down_sharp),
                                              ),
                                              Spacer(),
                                              FutureBuilder<String>(
                                                future: getCurrentUsername(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    final username =
                                                        snapshot.data;
                                                    return Column(
                                                      children: [
                                                        if (username ==
                                                            comment.author)
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  String?
                                                                      commentid =
                                                                      comment
                                                                          .commentid;
                                                                  deleteBlogComment(
                                                                      commentid);
                                                                },
                                                                icon: Icon(Icons
                                                                    .delete),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    );
                                                  } else {
                                                    return CircularProgressIndicator(); // Placeholder while fetching username
                                                  }
                                                },
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    comment.showReplies =
                                                        !comment.showReplies;
                                                  });
                                                },
                                                icon: Icon(Icons.reply),
                                              ),
                                              Text(
                                                '${comment.replyCount ?? 0}',
                                              ),
                                            ],
                                          ),
                                          // Add reply list
                                          if (comment.showReplies)
                                            Column(
                                              children: [
                                                // Existing replies
                                                Column(
                                                  children: comment.replies!
                                                      .map((reply) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 8),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(width: 32),
                                                            Text(
                                                              reply.author ??
                                                                  'Unknown',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              reply.createDate ??
                                                                  '',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                              ),
                                                            ),
                                                            SizedBox(width: 20),
                                                            Text(
                                                              reply.content ??
                                                                  '',
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ),
                                                // Reply section
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 8),
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Write your reply...',
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          // You can handle onChanged to update the reply text
                                                          // controller: replyController,
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      TextButton(
                                                        onPressed: () {
                                                          // Handle submitting the reply
                                                          // submitReply(replyController.text);
                                                        },
                                                        child: Text('Reply'),
                                                      ),
                                                      SizedBox(width: 8),
                                                      TextButton(
                                                        onPressed: () {
                                                          // Handle canceling the reply
                                                          // cancelReply();
                                                        },
                                                        child: Text('Cancel'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          const Divider()
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
