import 'package:bisleriumbloggers/controllers/Blogs/blogs_apis.dart';
import 'package:flutter/material.dart';
import 'package:bisleriumbloggers/models/blog/blog.dart';
import 'package:bisleriumbloggers/utilities/helpers/constants.dart';
import 'package:bisleriumbloggers/utilities/helpers/responsive.dart';
import 'package:bisleriumbloggers/utilities/widgets/blog_post.dart';
import 'package:bisleriumbloggers/utilities/widgets/categories.dart';
import 'package:bisleriumbloggers/utilities/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 1;
  late int totalPages;

  List<Blog> blogPosts = [];

  @override
  void initState() {
    super.initState();
    fetchBlogPosts();
    totalPages = (blogPosts.length / 5).ceil();
  }

  Future<void> fetchBlogPosts() async {
    try {
      List<Blog> posts = await fetchNoTokenBlogsDetails();
      setState(() {
        blogPosts = posts;
        totalPages = (blogPosts.length / 5).ceil();
      });
    } catch (e) {
      print('Error fetching blog posts: $e');
    }
  }

  Future<void> fetchRandomBlogs() async {
    try {
      List<Blog> posts = await fetchRandomBlogsDetails();
      setState(() {
        blogPosts = posts;
        totalPages = (blogPosts.length / 5).ceil();
      });
    } catch (e) {
      print('Error fetching random blogs: $e');
    }
  }

  Future<void> fetchPopularBlogs() async {
    try {
      List<Blog> posts = await fetchPopularBlogsDetails();
      setState(() {
        blogPosts = posts;
        totalPages = (blogPosts.length / 5).ceil();
      });
    } catch (e) {
      print('Error fetching popular blogs: $e');
    }
  }

  Future<void> fetchNoRecentBlogs() async {
    try {
      List<Blog> posts = await fetchNoRecentBlogsDetails();
      setState(() {
        blogPosts = posts;
        totalPages = (blogPosts.length / 5).ceil();
      });
    } catch (e) {
      print('Error fetching no recent blogs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Blog> paginatedPosts =
        blogPosts.skip((currentPage - 1) * 5).take(5).toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...paginatedPosts.map((blog) => BlogPostCard(blog: blog)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: currentPage > 1
                          ? () {
                              onPageChanged(currentPage - 1);
                            }
                          : null,
                    ),
                    Text('$currentPage of $totalPages'),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: currentPage < totalPages
                          ? () {
                              onPageChanged(currentPage + 1);
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (!Responsive.isMobile(context))
          SizedBox(width: BisleriumConstant.kDefaultPadding),
        // Sidebar
        if (!Responsive.isMobile(context))
          Expanded(
            child: Column(
              children: [
                Search(),
                SizedBox(height: BisleriumConstant.kDefaultPadding),
                Categories(
                  onCategorySelected: (category) {
                    // Call the appropriate method based on the selected category
                    if (category == 'Random') {
                      fetchRandomBlogs();
                    } else if (category == 'Popularity') {
                      fetchPopularBlogs();
                    } else if (category == 'Recency') {
                      fetchNoRecentBlogs();
                    }
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
    scrollToTop();
  }

  void scrollToTop() {
    // Using Scrollable.ensureVisible to scroll to the top
    Scrollable.ensureVisible(
      context,
      duration: Duration(milliseconds: 1500),
      alignment: 0.0,
    );
  }
}
