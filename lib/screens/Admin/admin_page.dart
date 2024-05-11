import 'package:bisleriumbloggers/controllers/Dashboard/dashboard_apis.dart';
import 'package:bisleriumbloggers/models/dashboard/dashboard_count.dart';
import 'package:bisleriumbloggers/models/dashboard/dashboard_post.dart';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);
  @override
  State<AdminPage> createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  bool isExpanded = false;
  String _selectedCountFilter = "All Time";
  String _selectedPostFilter = "All Time";
  String _selectedBloggerFilter = "All Time";
  bool _showDateRangeFields = false;
  bool _showMonthPostRangeFields = false;
  bool _showMonthBloggerRangeFields = false;
  DateTime? _startDate;
  DateTime? _endDate;
  DashboardCounts? countData;
  int? _selectedPostMonth;
  int? _selectedBloggerMonth;
  late List<PostSummaryDTO> _popularPosts = [];
  late List<UserPopularityDto> _popularBloggers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final session = await getSessionOrThrow();
      if (session.role != 'Admin') {
        GoRouter.of(context).push(Uri(path: '/access-denial').toString());
      } else {
        await fetchCountAllTimeData();
        await fetchPopularPostsAllTimeScreen();
        await fetchPopularBloggersAllTimeScreen();
      }
    } catch (e) {
      GoRouter.of(context).replace(Uri(path: '/login').toString());
    }
  }

  Future<void> fetchCountAllTimeData() async {
    try {
      DashboardCounts data = await fetchCountDashboard();
      setState(() {
        countData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchCountOnChosenDate(
      DateTime startDate, DateTime endDate) async {
    try {
      DashboardCounts data =
          await fetchCountOnChosenDateDashboard(startDate, endDate);
      setState(() {
        countData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Function to fetch data based on selected filter
  Future<void> fetchDataBasedOnFilter(String selectedFilter) async {
    if (selectedFilter == "All Time") {
      await fetchCountAllTimeData();
    } else if (selectedFilter == "Certain Date") {
      if (_startDate != null && _endDate != null) {
        await fetchCountOnChosenDate(_startDate!, _endDate!);
      } else {
        // Handle error: Start date or end date is not selected
      }
    }
  }

  Future<void> fetchPopularPostsAllTimeScreen() async {
    try {
      _popularPosts = await fetchPopularPostsAllTime();
      setState(() {});
    } catch (e) {
      print('Failed to load popular posts: $e');
      // Handle error
    }
  }

  Future<void> fetchPopularBloggersAllTimeScreen() async {
    try {
      _popularBloggers = await fetchPopularBloggerAllTime();
      setState(() {});
    } catch (e) {
      print('Failed to load popular posts: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
              extended: isExpanded,
              backgroundColor: Colors.deepPurple.shade400,
              unselectedIconTheme:
                  const IconThemeData(color: Colors.white, opacity: 1),
              unselectedLabelTextStyle: const TextStyle(
                color: Colors.white,
              ),
              selectedIconTheme:
                  IconThemeData(color: Colors.deepPurple.shade900),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("Home"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.add_box),
                  label: Text("Add Admin"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text("Profile"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text("Settings"),
                ),
              ],
              selectedIndex: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: const Icon(Icons.menu),
                        ),
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://i.pngimg.me/thumb/f/720/c3f2c592f9.jpg"),
                          radius: 26.0,
                        ),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .push(Uri(path: '/addAdmin').toString());
                          },
                          child: Text(
                            'Add Admin',
                            style: TextStyle(
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.deepPurple.shade400,
                          ),
                          label: Text(
                            _selectedCountFilter == "All Time"
                                ? "All Time"
                                : _formatSelectedDateRange(),
                            style: TextStyle(
                              color: Colors.deepPurple.shade400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        if (_showDateRangeFields)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 250, // Adjust the width as needed
                                child: TextFormField(
                                  onTap: () {
                                    _selectStartDate(context);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Start Date',
                                  ),
                                  readOnly: true,
                                  controller: TextEditingController(
                                      text: _startDate != null
                                          ? _formatDate(_startDate!)
                                          : ''),
                                ),
                              ),
                              SizedBox(
                                width: 250, // Adjust the width as needed
                                child: TextFormField(
                                  onTap: () {
                                    _selectEndDate(context);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'End Date',
                                  ),
                                  readOnly: true,
                                  controller: TextEditingController(
                                      text: _endDate != null
                                          ? _formatDate(_endDate!)
                                          : ''),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_startDate != null && _endDate != null) {
                                    setState(() {
                                      fetchDataBasedOnFilter("Certain Date");
                                    });
                                  } else {}
                                },
                                child: const Text("Filter"),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            DropdownButton(
                              hint: const Text("Filter by"),
                              value: _selectedCountFilter,
                              items: const [
                                DropdownMenuItem(
                                  value: "All Time",
                                  child: Text("All Time"),
                                ),
                                DropdownMenuItem(
                                  value: "Certain Date",
                                  child: Text("Certain Date"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCountFilter = value.toString();
                                  if (_selectedCountFilter == "Certain Date") {
                                    _showDateRangeFields = true;
                                  } else {
                                    _showDateRangeFields = false;
                                  }
                                  fetchDataBasedOnFilter(_selectedCountFilter);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.account_box,
                                        size: 26.0,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Users",
                                        style: TextStyle(
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "${countData != null ? countData!.userCount : 0}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.post_add,
                                        size: 26.0,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Posts",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "${countData != null ? countData!.postCount : 0}",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.people,
                                        size: 26.0,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          fontSize: 26.0,
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "${countData != null ? countData!.totalCommentCount : 0}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        size: 26.0,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "UpVotes",
                                        style: TextStyle(
                                          fontSize: 26.0,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "${countData != null ? countData!.upvoteCount : 0}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_downward,
                                        size: 26.0,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "DownVote",
                                        style: TextStyle(
                                          fontSize: 26.0,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "${countData != null ? countData!.downvoteCount : 0}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Now let's set the article section
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Blogs Data",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "2 new Articles",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            DropdownButton(
                              hint: const Text("Filter by"),
                              value: _selectedPostFilter,
                              items: const [
                                DropdownMenuItem(
                                  value: "All Time",
                                  child: Text("All Time"),
                                ),
                                DropdownMenuItem(
                                  value: "Monthly",
                                  child: Text("Monthly"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedPostFilter = value.toString();
                                  if (_selectedPostFilter == "Monthly") {
                                    _showMonthPostRangeFields = true;
                                  } else {
                                    _showMonthPostRangeFields = false;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        if (_showMonthPostRangeFields)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<int>(
                                hint: const Text('Choose a month'),
                                value: _selectedPostMonth,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedPostMonth = newValue;
                                  });
                                },
                                items: [
                                  for (int i = 1; i <= 12; i++)
                                    DropdownMenuItem(
                                      value: i,
                                      child: Text(_getMonthName(i)),
                                    ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_selectedPostMonth != null) {
                                    try {
                                      setState(() {});
                                      _popularPosts =
                                          await getPopularPostsChosenMonth(
                                              _selectedPostMonth!);
                                      setState(() {});
                                    } catch (e) {
                                      print('Failed to load popular posts: $e');
                                      // Handle error
                                    }
                                  }
                                },
                                child: const Text("Filter"),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DataTable(
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.grey.shade200),
                          columns: const [
                            DataColumn(label: Text("ID")),
                            DataColumn(label: Text("Blog Title")),
                            DataColumn(label: Text("Creation Date")),
                            DataColumn(label: Text("Popularity")),
                            DataColumn(label: Text("Comments")),
                          ],
                          rows: _popularPosts.map((post) {
                            return DataRow(cells: [
                              DataCell(Text(post.postId.toString())),
                              DataCell(Text(post.title)),
                              DataCell(Text(post.createdAt.toString())),
                              DataCell(Text("${post.popularity}")),
                              DataCell(Text("${post.commentsCount}")),
                            ]);
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                      ],
                    ),
                    //Now let's set the article section
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Bloggers Data",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "2 new Articles",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            DropdownButton(
                              hint: const Text("Filter by"),
                              value: _selectedBloggerFilter,
                              items: const [
                                DropdownMenuItem(
                                  value: "All Time",
                                  child: Text("All Time"),
                                ),
                                DropdownMenuItem(
                                  value: "Monthly",
                                  child: Text("Monthly"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedBloggerFilter = value.toString();
                                  if (_selectedBloggerFilter == "Monthly") {
                                    _showMonthBloggerRangeFields = true;
                                  } else {
                                    _showMonthBloggerRangeFields = false;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        if (_showMonthBloggerRangeFields)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<int>(
                                hint: const Text('Choose a month'),
                                value: _selectedBloggerMonth,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedBloggerMonth = newValue;
                                  });
                                },
                                items: [
                                  for (int j = 1; j <= 12; j++)
                                    DropdownMenuItem(
                                      value: j,
                                      child: Text(_getMonthName(j)),
                                    ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_selectedBloggerMonth != null) {
                                    try {
                                      setState(() {});
                                      _popularBloggers =
                                          await getPopularBloggersChosenMonth(
                                              _selectedBloggerMonth!);
                                      setState(() {});
                                    } catch (e) {
                                      print(
                                          'Failed to load popular blogger: $e');
                                      // Handle error
                                    }
                                  }
                                },
                                child: const Text("Filter"),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DataTable(
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.grey.shade200),
                          columns: const [
                            DataColumn(label: Text("ID")),
                            DataColumn(label: Text("Username")),
                            DataColumn(label: Text("Creation Date")),
                            DataColumn(label: Text("Popularity")),
                            DataColumn(label: Text("Total Post")),
                          ],
                          rows: _popularBloggers.map((post) {
                            return DataRow(cells: [
                              DataCell(Text(post.userId.toString())),
                              DataCell(Text(post.username)),
                              DataCell(Text(post.createdAt.toString())),
                              DataCell(Text("${post.popularityScore}")),
                              DataCell(Text("${post.totalPosts}")),
                            ]);
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      //let's add the floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
      ),
    );
  }

  String _formatSelectedDateRange() {
    return _startDate != null && _endDate != null
        ? '${_formatDate(_startDate!)} -- ${_formatDate(_endDate!)}'
        : '';
  }

  String _formatDate(DateTime date) {
    return "${date.year}, ${_getMonthName(date.month)} ${date.day}";
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1969, 8),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1969, 8),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }
}
