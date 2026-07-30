import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ---------------------------------------------------------------------------
// DTO (Data Transfer Object)
// ---------------------------------------------------------------------------
class Post {
  final int? id;
  final int userId;
  final String title;
  final String body;

  Post({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // Convert JSON (Map) -> Post object
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  // Convert Post object -> JSON (Map) for sending in a POST request
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() => 'Post(id: $id, title: $title)';
}

// ---------------------------------------------------------------------------
// API service - keeps HTTP logic separate from the UI
// ---------------------------------------------------------------------------
class PostApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<Post> getPost(int id) async {
    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Post.fromJson(json);
    } else {
      throw Exception('GET failed: ${response.statusCode}');
    }
  }

  Future<Post> createPost(Post post) async {
    final url = Uri.parse(_baseUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Post.fromJson(json);
    } else {
      throw Exception('POST failed: ${response.statusCode}');
    }
  }
}

// ---------------------------------------------------------------------------
// UI
// ---------------------------------------------------------------------------
class ApiDemo extends StatefulWidget {
  const ApiDemo({super.key});

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  final PostApiService _apiService = PostApiService();
  String _result = 'No data yet';

  Future<void> fetchData() async {
    try {
      final Post post = await _apiService.getPost(1);
      setState(() {
        _result = 'GET success: ${post.title}';
      });
    } catch (e) {
      setState(() {
        _result = 'GET error: $e';
      });
    }
  }

  Future<void> postData() async {
    final newPost = Post(userId: 1, title: 'foo', body: 'bar');

    try {
      final Post created = await _apiService.createPost(newPost);
      setState(() {
        _result = 'POST success: id=${created.id}';
      });
    } catch (e) {
      setState(() {
        _result = 'POST error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP GET/POST Demo (DTO)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_result, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: fetchData, child: const Text('GET')),
            ElevatedButton(onPressed: postData, child: const Text('POST')),
          ],
        ),
      ),
    );
  }
}