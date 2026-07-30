import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiDemo extends StatefulWidget {
  const ApiDemo({super.key});

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  String _result = 'No data yet';

  // GET request
  Future<void> fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = 'GET success: ${data['title']}';
        });
      } else {
        setState(() {
          _result = 'GET failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'GET error: $e';
      });
    }
  }

  // POST request
  Future<void> postData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'title': 'foo', 'body': 'bar', 'userId': 1}),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = 'POST success: id=${data['id']}';
        });
      } else {
        setState(() {
          _result = 'POST failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'POST error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP GET/POST Demo')),
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
