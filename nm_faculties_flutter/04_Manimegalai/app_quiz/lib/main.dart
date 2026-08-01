import 'dart:io';

void main() {
  int score = 0;

  print("========== QUIZ MASTER ==========");
  print("1. What is the capital of India?");
  print("a) Chennai");
  print("b) Delhi");
  print("c) Mumbai");
  print("d) Kolkata");
  stdout.write("Answer: ");
  String? ans1 = stdin.readLineSync();

  if (ans1!.toLowerCase() == "b") {
    score++;
  }

  print("\n2. Flutter programming language is?");
  print("a) Java");
  print("b) Kotlin");
  print("c) Dart");
  print("d) Python");
  stdout.write("Answer: ");
  String? ans2 = stdin.readLineSync();

  if (ans2!.toLowerCase() == "c") {
    score++;
  }

  print("\n3. 10 + 20 = ?");
  print("a) 10");
  print("b) 20");
  print("c) 30");
  print("d) 40");
  stdout.write("Answer: ");
  String? ans3 = stdin.readLineSync();

  if (ans3!.toLowerCase() == "c") {
    score++;
  }

  print("\n========== RESULT ==========");
  print("Total Score : $score / 3");

  if (score == 3) {
    print("Excellent! 🏆");
  } else if (score == 2) {
    print("Good Job! 👍");
  } else {
    print("Keep Practicing! 📖");
  }
}