import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";
  double firstNumber = 0;
  String operation = "";
  bool isNewNumber = true;

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        display = "0";
        firstNumber = 0;
        operation = "";
        isNewNumber = true;
      } else if (value == "+" ||
          value == "-" ||
          value == "×" ||
          value == "÷") {
        firstNumber = double.parse(display);
        operation = value;
        isNewNumber = true;
      } else if (value == "=") {
        double secondNumber = double.parse(display);
        double result = 0;

        switch (operation) {
          case "+":
            result = firstNumber + secondNumber;
            break;
          case "-":
            result = firstNumber - secondNumber;
            break;
          case "×":
            result = firstNumber * secondNumber;
            break;
          case "÷":
            if (secondNumber != 0) {
              result = firstNumber / secondNumber;
            }
            break;
        }

        display = result.toString();

        if (display.endsWith(".0")) {
          display = display.replaceAll(".0", "");
        }

        isNewNumber = true;
      } else {
        if (isNewNumber) {
          display = value;
          isNewNumber = false;
        } else {
          display += value;
        }
      }
    });
  }

  Widget button(String text, Color color) {
    return GestureDetector(
      onTap: () => onButtonPressed(text),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [

              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    display,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button("7", Colors.grey.shade900),
                  button("8", Colors.grey.shade900),
                  button("9", Colors.grey.shade900),
                  button("÷", Colors.orange),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button("4", Colors.grey.shade900),
                  button("5", Colors.grey.shade900),
                  button("6", Colors.grey.shade900),
                  button("×", Colors.orange),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button("1", Colors.grey.shade900),
                  button("2", Colors.grey.shade900),
                  button("3", Colors.grey.shade900),
                  button("-", Colors.orange),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button("0", Colors.grey.shade900),
                  button(".", Colors.grey.shade900),
                  button("=", Colors.orange),
                  button("+", Colors.orange),
                ],
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => onButtonPressed("C"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Clear",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
