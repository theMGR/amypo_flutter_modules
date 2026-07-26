// Module 1 practice exercises — reference solutions.
// Run with: dart run exercises/solutions.dart

void q1FizzBuzz() {
  for (int i = 1; i <= 20; i++) {
    if (i % 15 == 0) {
      print('FizzBuzz');
    } else if (i % 3 == 0) {
      print('Fizz');
    } else if (i % 5 == 0) {
      print('Buzz');
    } else {
      print(i);
    }
  }
}

int q2SumOfEvens(List<int> numbers) {
  int sum = 0;
  for (final n in numbers) {
    if (n % 2 == 0) sum += n;
  }
  return sum;
}

bool q3IsPalindrome(String s) {
  final cleaned = s.toLowerCase();
  final reversed = cleaned.split('').reversed.join();
  return cleaned == reversed;
}

int Function(int) q4MakeMultiplier(int factor) {
  return (n) => n * factor;
}

abstract class Q5Shape {
  double area();
}

class Q5Circle extends Q5Shape {
  final double radius;
  Q5Circle(this.radius);

  @override
  double area() => 3.14159 * radius * radius;
}

class Q5Rectangle extends Q5Shape {
  final double width;
  final double height;
  Q5Rectangle(this.width, this.height);

  @override
  double area() => width * height;
}

Future<int> fetchValue(int id) async {
  await Future.delayed(const Duration(milliseconds: 100));
  return id * 5;
}

Future<int> q6FetchAndDouble(int id) async {
  final value = await fetchValue(id);
  return value * 2;
}

Future<int> q7CapstoneSumAllDoubled(List<int> ids) async {
  final results = await Future.wait(ids.map(q6FetchAndDouble));
  return results.fold<int>(0, (sum, v) => sum + v);
}

Future<void> main() async {
  print('--- Q1: FizzBuzz ---');
  q1FizzBuzz();

  print('\n--- Q2: Sum of evens ---');
  print(q2SumOfEvens([1, 2, 3, 4, 5, 6])); // 12

  print('\n--- Q3: Palindrome ---');
  print(q3IsPalindrome('Racecar')); // true
  print(q3IsPalindrome('Dart')); // false

  print('\n--- Q4: Multiplier closure ---');
  final triple = q4MakeMultiplier(3);
  print(triple(7)); // 21

  print('\n--- Q5: Shapes ---');
  final Q5Shape circle = Q5Circle(2);
  final Q5Shape rect = Q5Rectangle(3, 4);
  print('circle area=${circle.area().toStringAsFixed(2)}');
  print('rectangle area=${rect.area()}');

  print('\n--- Q6: Async fetch and double ---');
  print(await q6FetchAndDouble(4)); // 40

  print('\n--- Q7 Capstone: sum all doubled (concurrent) ---');
  print(await q7CapstoneSumAllDoubled([1, 2, 3])); // fetchValue: 5,10,15 -> doubled: 10,20,30 -> sum=60
}
