import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the capital of India?",
      "answers": ["Mumbai", "New Delhi", "Chennai", "Kolkata"],
      "correct": "New Delhi"
    },
    {
      "question": "Flutter uses which language?",
      "answers": ["Java", "Dart", "Python", "C++"],
      "correct": "Dart"
    },
    {
      "question": "How many days are there in a week?",
      "answers": ["5", "6", "7", "8"],
      "correct": "7"
    },
  ];

  int index = 0;
  int score = 0;

  void checkAnswer(String answer) {
    if (answer == questions[index]["correct"]) {
      score++;
    }

    setState(() {
      index++;
    });
  }

  void restartQuiz() {
    setState(() {
      index = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (index == questions.length) {
      return Scaffold(
        appBar: AppBar(title: const Text("Quiz App")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Quiz Completed!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Score: $score/${questions.length}",
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: restartQuiz,
                child: const Text("Restart Quiz"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questions[index]["question"],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...(questions[index]["answers"] as List<String>).map((answer) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(answer),
                  child: Text(answer),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}