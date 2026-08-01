import 'package:flutter/material.dart';
import 'background.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 45)),
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}
