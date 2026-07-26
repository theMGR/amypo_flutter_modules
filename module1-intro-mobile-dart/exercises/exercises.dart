// Module 1 practice exercises — learner-facing.
// Fill in each TODO, then compare against exercises/solutions.dart.
// Run with: dart run exercises/exercises.dart

// Q1 (Session 4 — control flow): Print "Fizz" for multiples of 3, "Buzz" for
// multiples of 5, "FizzBuzz" for multiples of both, otherwise the number,
// for i from 1 to 20.
void q1FizzBuzz() {
  // TODO: implement FizzBuzz for i in 1..20
}

// Q2 (Session 4 — control flow): Given a List<int>, return the sum of only
// the even numbers using a for-in loop.
int q2SumOfEvens(List<int> numbers) {
  // TODO: implement
  return 0;
}

// Q3 (Session 5 — functions): Write a function `isPalindrome(String s)` that
// returns true if `s` reads the same forwards and backwards (case-insensitive).
bool q3IsPalindrome(String s) {
  // TODO: implement
  return false;
}

// Q4 (Session 5 — closures): Write `makeMultiplier(int factor)` that returns
// a function taking an int and returning it multiplied by `factor`.
int Function(int) q4MakeMultiplier(int factor) {
  // TODO: implement
  return (n) => n;
}

// Q5 (Session 6 — OOP): Model a `Shape` abstract class with an `area()`
// method, and two subclasses `Circle` and `Rectangle` that implement it.
abstract class Q5Shape {
  double area();
}

// TODO: class Q5Circle extends Q5Shape { ... }
// TODO: class Q5Rectangle extends Q5Shape { ... }

// Q6 (Session 7 — async): Write an async function `fetchAndDouble(int id)`
// that awaits `fetchValue(id)` below, then returns double the result.
Future<int> fetchValue(int id) async {
  await Future.delayed(const Duration(milliseconds: 100));
  return id * 5;
}

Future<int> q6FetchAndDouble(int id) async {
  // TODO: implement using await
  return 0;
}

// Capstone (Q7): combine concepts — given a list of user IDs, fetch each
// user's value concurrently (Future.wait), then return the sum of all
// doubled values.
Future<int> q7CapstoneSumAllDoubled(List<int> ids) async {
  // TODO: implement using Future.wait and q6FetchAndDouble
  return 0;
}

Future<void> main() async {
  print('Fill in the TODOs in this file, then run exercises/solutions.dart to check your work.');
}
