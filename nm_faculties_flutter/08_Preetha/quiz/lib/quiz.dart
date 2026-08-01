import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';
import 'result.dart';
import 'background.dart';

class Quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<Quiz> with SingleTickerProviderStateMixin {
  final _questions = const [
    {
      'questionText': 'Who developed Flutter?',
      'answers': [
        {'text': 'Google', 'score': 1},
        {'text': 'Facebook', 'score': 0},
        {'text': 'Microsoft', 'score': 0},
        {'text': 'Adobe', 'score': 0},
      ],
    },
    {
      'questionText': 'Which programming language is used in Flutter?',
      'answers': [
        {'text': 'Java', 'score': 0},
        {'text': 'Dart', 'score': 1},
        {'text': 'Kotlin', 'score': 0},
        {'text': 'Swift', 'score': 0},
      ],
    },
    {
      'questionText': 'Flutter is mainly used for?',
      'answers': [
        {'text': 'Web Development', 'score': 0},
        {'text': 'Mobile App Development', 'score': 1},
        {'text': 'Game Development', 'score': 0},
        {'text': 'Data Science', 'score': 0},
      ],
    },
    {
      'questionText': 'Which widget is the root of a Flutter app?',
      'answers': [
        {'text': 'MaterialApp', 'score': 1},
        {'text': 'Scaffold', 'score': 0},
        {'text': 'Container', 'score': 0},
        {'text': 'Column', 'score': 0},
      ],
    },
    {
      'questionText': 'Which company created Dart?',
      'answers': [
        {'text': 'Google', 'score': 1},
        {'text': 'Oracle', 'score': 0},
        {'text': 'IBM', 'score': 0},
        {'text': 'Microsoft', 'score': 0},
      ],
    },
    {
      'questionText': 'Which widget is used for layout in Flutter?',
      'answers': [
        {'text': 'Row', 'score': 1},
        {'text': 'Column', 'score': 1},
        {'text': 'Stack', 'score': 1},
        {'text': 'All of the above', 'score': 1},
      ],
    },
    {
      'questionText': 'Hot Reload in Flutter is used for?',
      'answers': [
        {'text': 'Restarting app', 'score': 0},
        {'text': 'Quickly updating UI', 'score': 1},
        {'text': 'Clearing cache', 'score': 0},
        {'text': 'Debugging errors', 'score': 0},
      ],
    },
    {
      'questionText': 'Which widget provides a default app structure?',
      'answers': [
        {'text': 'Scaffold', 'score': 1},
        {'text': 'Container', 'score': 0},
        {'text': 'AppBar', 'score': 0},
        {'text': 'Text', 'score': 0},
      ],
    },
    {
      'questionText': 'Which command creates a new Flutter project?',
      'answers': [
        {'text': 'flutter new project', 'score': 0},
        {'text': 'flutter create project_name', 'score': 1},
        {'text': 'flutter init', 'score': 0},
        {'text': 'flutter start', 'score': 0},
      ],
    },
    {
      'questionText': 'Which widget is used to display text?',
      'answers': [
        {'text': 'Text', 'score': 1},
        {'text': 'Label', 'score': 0},
        {'text': 'Paragraph', 'score': 0},
        {'text': 'String', 'score': 0},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _questionIndex++;
      _controller.reset();
      _controller.forward();
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Quiz')),
      body: _questionIndex < _questions.length
          ? Column(
        children: [
          LinearProgressIndicator(
            value: (_questionIndex + 1) / _questions.length,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Question(_questions[_questionIndex]['questionText'] as String),
                  ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
                      .map((answer) {
                    return Answer(() => _answerQuestion(answer['score'] as int), answer['text'] as String);
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      )
          : Result(_totalScore, _questions.length, _resetQuiz),
    );
  }
}
