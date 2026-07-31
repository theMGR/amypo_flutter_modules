import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Quiz App"),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Question:",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "What is flutter?",
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = "Wrong Answer";
                });
              },
              child: const Text(". Programming Language"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = "Correct Answer";
                });
              },
              child: const Text(". Mobile App Development Framework"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = "Wrong Answer";
                });
              },
              child: const Text("Database"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = "Wrong Answer";
                });
              },
              child: const Text("Amazon"),
            ),

            const SizedBox(height: 30),

            Text(
              result,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}