import 'package:flutter/material.dart';
import 'background.dart';
class Result extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback resetHandler;

  Result(this.score, this.total, this.resetHandler);

  String get resultPhrase {
    if (score == total) return 'Perfect! 🎉';
    else if (score > total / 2) return 'Good job!';
    else return 'Keep practicing!';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quiz Completed!\nYour Score: $score / $total\n$resultPhrase',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          ElevatedButton(
            child: Text('Restart Quiz'),
            onPressed: resetHandler,
          ),
        ],
      ),
    );
  }
}
