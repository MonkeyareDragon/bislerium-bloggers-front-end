import 'dart:convert';
import 'dart:typed_data';
import 'package:bisleriumbloggers/utilities/helpers/sesson_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:bisleriumbloggers/utilities/helpers/url_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class SubmitPost extends StatefulWidget {
  const SubmitPost({Key? key}) : super(key: key);
  @override
  State<SubmitPost> createState() => _SubmitPostState();
}

class _SubmitPostState extends State<SubmitPost> {
  Uint8List? _imageData;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> getImage() async {
    final pickedFile = await ImagePickerWeb.getImageAsBytes();

    if (pickedFile != null) {
      // Check if image size is less than or equal to 3 MB
      if (pickedFile.lengthInBytes <= 3 * 1024 * 1024) {
        setState(() {
          _imageData = pickedFile;
        });
      } else {
        // Display an error message if image size exceeds 3 MB
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Image Size Limit Exceeded'),
            content: Text(
                'Please select an image less than or equal to 3 MB in size.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _postBlog() async {
    String title = _titleController.text;
    String content = _contentController.text;

    // Check if required fields are empty
    if (title.isEmpty || content.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Missing Information'),
          content: Text('Please fill in all required fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Check if image is selected
    if (_imageData == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No Image Selected'),
          content: Text('Please select an image.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      // Get user session
      final session = await getSessionOrThrow();

      // Construct form-data
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://127.0.0.1:5181/post/add/'))
        ..headers['Authorization'] = 'Bearer ${session.accessToken}'
        ..fields['title'] = title
        ..fields['content'] = content
        ..files.add(
          http.MultipartFile(
            'imageFile',
            http.ByteStream.fromBytes(
                _imageData!), // Wrap image data in ByteStream
            _imageData!.length, // Length of image data
            filename: 'image.jpg', // Set filename
            contentType: MediaType.parse(
                lookupMimeType('image.jpg')!), // Determine content type
          ),
        );

      // Send request
      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        // Blog created successfully
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Blog created successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  GoRouter.of(context).push(Uri(path: '/').toString());
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Failed to create blog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to create blog. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error creating blog: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create blog. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Blog'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: getImage,
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[200],
                child: _imageData == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: 100,
                      )
                    : Image.memory(
                        _imageData!,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _contentController,
              maxLines: 8,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _postBlog, // Call the function to post the blog
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
