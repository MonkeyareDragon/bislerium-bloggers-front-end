import 'package:bisleriumbloggers/controllers/Vote/vote_apis.dart';
import 'package:bisleriumbloggers/controllers/others/notification_apis.dart';
import 'package:bisleriumbloggers/models/session/user_session.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:flutter/material.dart';
import 'package:bisleriumbloggers/models/blog/blog.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/helpers/constants.dart';
import 'package:bisleriumbloggers/utilities/helpers/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BlogPostCard extends StatefulWidget {
  final Blog blog;
  const BlogPostCard({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<BlogPostCard> {
  bool liked = false;
  bool disliked = false;
  String? voteId;

  Future<void> setNotification(String? postId) async {
    final UserSession session = await getSessionOrThrow();
    if (session.username != widget.blog.author) {
      String notificationNote = "${session.username} have like your blog.";
      await addNotification(postId, notificationNote);
    }
  }

  Future<String> getCurrentUsername() async {
    try {
      final UserSession session = await getSessionOrThrow();
      return session.username;
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BisleriumConstant.kDefaultPadding),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.78,
            child: Image.network(widget.blog.image!),
          ),
          Container(
            padding: EdgeInsets.all(BisleriumConstant.kDefaultPadding),
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
                      widget.blog.author!.toUpperCase(),
                      style: TextStyle(
                        color: BisleriumColor.kDarkBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: BisleriumConstant.kDefaultPadding),
                    Text(
                      widget.blog.createDate ?? "No Date",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: BisleriumConstant.kDefaultPadding),
                  child: Text(
                    widget.blog.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ? 32 : 24,
                      fontFamily: "Raleway",
                      color: BisleriumColor.kDarkBlackColor,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  widget.blog.description!,
                  maxLines: 4,
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: BisleriumConstant.kDefaultPadding),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(Uri(
                          path: '/details/${widget.blog.id}',
                        ).toString());
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: BisleriumConstant.kDefaultPadding / 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: BisleriumColor.kPrimaryColor, width: 3),
                          ),
                        ),
                        child: Text(
                          "Read More",
                          style:
                              TextStyle(color: BisleriumColor.kDarkBlackColor),
                        ),
                      ),
                    ),
                    Spacer(),
                    FutureBuilder<String>(
                      future: getCurrentUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final username = snapshot.data;
                          return Row(
                            children: [
                              if (username!.isNotEmpty)
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            liked = !liked;
                                            if (liked) {
                                              widget.blog.voteCount =
                                                  (widget.blog.voteCount ?? 0) +
                                                      1;
                                              if (disliked) {
                                                updateVoteType(widget.blog.id,
                                                    null, null, 1);
                                                widget.blog.voteCount =
                                                    (widget.blog.voteCount ??
                                                            0) +
                                                        1;
                                                disliked = false;
                                              } else {
                                                createVote(widget.blog.id, null,
                                                    null, 1);
                                                setNotification(widget.blog.id);
                                              }
                                            } else {
                                              widget.blog.voteCount =
                                                  (widget.blog.voteCount ?? 0) -
                                                      1;
                                              removeVote(
                                                  widget.blog.id, null, null);
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.thumb_up_sharp),
                                        color: liked
                                            ? BisleriumColor.kPrimaryColor
                                            : BisleriumColor.backgroundColor),
                                    Text('${widget.blog.voteCount ?? 0}'),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            disliked = !disliked;
                                            if (disliked) {
                                              widget.blog.voteCount =
                                                  (widget.blog.voteCount ?? 0) -
                                                      1;
                                              if (liked) {
                                                updateVoteType(widget.blog.id,
                                                    null, null, 0);
                                                widget.blog.voteCount =
                                                    (widget.blog.voteCount ??
                                                            0) -
                                                        1;
                                                liked = false;
                                              } else {
                                                createVote(widget.blog.id, null,
                                                    null, 0);
                                              }
                                            } else {
                                              widget.blog.voteCount =
                                                  (widget.blog.voteCount ?? 0) +
                                                      1;
                                              removeVote(
                                                  widget.blog.id, null, null);
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.thumb_down_sharp),
                                        color: disliked
                                            ? BisleriumColor.kPrimaryColor
                                            : BisleriumColor.backgroundColor),
                                  ],
                                )
                              else
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          GoRouter.of(context).push(
                                              Uri(path: '/login').toString());
                                        },
                                        icon: Icon(Icons.thumb_up_sharp),
                                        color: liked
                                            ? BisleriumColor.kPrimaryColor
                                            : BisleriumColor.backgroundColor),
                                    Text('${widget.blog.voteCount ?? 0}'),
                                    IconButton(
                                        onPressed: () {
                                          GoRouter.of(context).push(
                                              Uri(path: '/login').toString());
                                        },
                                        icon: Icon(Icons.thumb_down_sharp),
                                        color: disliked
                                            ? BisleriumColor.kPrimaryColor
                                            : BisleriumColor.backgroundColor),
                                  ],
                                )
                            ],
                          );
                        } else {
                          return CircularProgressIndicator(); // Placeholder while fetching username
                        }
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                          "assets/icons/feather_message-square.svg"),
                      onPressed: () {},
                    ),
                    Text('${widget.blog.commentCount ?? 0}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
