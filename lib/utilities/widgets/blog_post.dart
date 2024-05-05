import 'package:flutter/material.dart';
import 'package:bisleriumbloggers/models/blog/blog.dart';
import 'package:bisleriumbloggers/utilities/helpers/app_colors.dart';
import 'package:bisleriumbloggers/utilities/helpers/constants.dart';
import 'package:bisleriumbloggers/utilities/helpers/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BisleriumConstant.kDefaultPadding),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.78,
            child: Image.asset(widget.blog.image!),
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
                      widget.blog.updateDate!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: BisleriumConstant.kDefaultPadding),
                  child: Text(
                    widget.blog.title!,
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
                      onPressed: () {},
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
                    IconButton(
                        onPressed: () {
                          setState(() {
                            liked = !liked;
                            if (liked) {
                              widget.blog.voteCount =
                                  (widget.blog.voteCount ?? 0) + 1;
                              if (disliked) {
                                widget.blog.voteCount =
                                    (widget.blog.voteCount ?? 0) + 1;
                                disliked = false;
                              }
                            } else {
                              widget.blog.voteCount =
                                  (widget.blog.voteCount ?? 0) - 1;
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
                                  (widget.blog.voteCount ?? 0) - 1;
                              if (liked) {
                                widget.blog.voteCount =
                                    (widget.blog.voteCount ?? 0) - 1;
                                liked = false;
                              }
                            } else {
                              widget.blog.voteCount =
                                  (widget.blog.voteCount ?? 0) + 1;
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
