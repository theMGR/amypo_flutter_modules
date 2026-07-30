import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: const ApiDemo()));
}

class ApiDemo extends StatefulWidget {
  const ApiDemo({super.key});

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  String _result = 'No data yet';

  // Pretty-printer for JSON logs
  final JsonEncoder _prettyJson = const JsonEncoder.withIndent('  ');

  void _logRequest({
    required String method,
    required Uri url,
    Map<String, String>? headers,
    Object? body,
  }) {
    final logMap = {
      'method': method,
      'url': url.toString(),
      if (headers != null) 'headers': headers,
      if (body != null) 'body': body,
    };
    debugPrint('---- REQUEST ----');
    debugPrint(_prettyJson.convert(logMap));
  }

  void _logResponse(http.Response response) {
    Object? decodedBody;
    try {
      decodedBody = jsonDecode(response.body);
    } catch (_) {
      decodedBody = response.body; // not valid JSON, log as raw string
    }

    final logMap = {
      'statusCode': response.statusCode,
      'headers': response.headers,
      'body': decodedBody,
    };
    debugPrint('---- RESPONSE ----');
    debugPrint(_prettyJson.convert(logMap));
  }

  // GET request
  Future<void> fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

    _logRequest(method: 'GET', url: url);

    try {
      final response = await http.get(url);
      _logResponse(response);

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
      debugPrint('---- REQUEST ERROR ----\n$e');
      setState(() {
        _result = 'GET error: $e';
      });
    }
  }

  // POST request
  Future<void> postData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final bodyMap = {'title': 'foo', 'body': 'bar', 'userId': 1};

    _logRequest(method: 'POST', url: url, headers: headers, body: bodyMap);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(bodyMap),
      );
      _logResponse(response);

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
      debugPrint('---- REQUEST ERROR ----\n$e');
      setState(() {
        _result = 'POST error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP GET/POST Demo (with logging)')),
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