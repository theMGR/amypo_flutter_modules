import 'package:flutter/material.dart';
import 'quiz.dart';
import 'background.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Quiz(),
    );
  }
}
