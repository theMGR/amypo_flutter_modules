// Session 2 — Dart syntax, variables & data types

void runVariablesAndDataTypes() {
  print('\n--- 02: Variables & Data Types ---');

  // var: type inferred once at first assignment
  var name = 'Ada';
  // final: runtime constant, set once
  final int age = 30;
  // const: compile-time constant
  const double pi = 3.14159;

  // Core built-in types
  int score = 95;
  double average = 87.5;
  String city = 'Chennai';
  bool isActive = true;

  // Collections
  List<String> languages = ['Dart', 'Kotlin', 'Swift'];
  Map<String, int> inventory = {'apples': 10, 'oranges': 5};
  Set<int> uniqueIds = {1, 2, 3}..add(2); // adding 2 again is a no-op (already present)

  print('$name is $age years old (const pi=$pi)');
  print('score=$score average=$average city=$city isActive=$isActive');
  print('languages=$languages');
  print('inventory=$inventory');
  print('uniqueIds=$uniqueIds');

  // Null safety: a nullable type must be explicitly marked with `?`
  String? nickname; // defaults to null
  nickname ??= 'no nickname set';
  print('nickname=$nickname');
}
