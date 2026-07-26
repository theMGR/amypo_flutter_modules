// Session 5 — Functions: params, arrow syntax, closures, higher-order functions

// Positional required params
int add(int a, int b) => a + b;

// Optional positional params (in [])
String greet(String name, [String greeting = 'Hello']) => '$greeting, $name!';

// Named params (in {}), some required
String describePerson({required String name, int age = 18}) => '$name is $age years old';

// Arrow function (single expression body)
int square(int x) => x * x;

// Higher-order function: takes a function as a parameter
int applyTwice(int Function(int) fn, int value) => fn(fn(value));

// Closure: returns a function that captures `start`
int Function() counterFrom(int start) {
  int count = start;
  return () {
    count++;
    return count;
  };
}

void runFunctions() {
  print('\n--- 05: Functions ---');
  print('add(2,3)=${add(2, 3)}');
  print('greet: ${greet('Ravi')} / ${greet('Ravi', 'Hi')}');
  print('describePerson: ${describePerson(name: 'Meena', age: 25)}');
  print('square(5)=${square(5)}');
  print('applyTwice(square,3)=${applyTwice(square, 3)}');

  final counter = counterFrom(10);
  print('closure counter calls: ${counter()}, ${counter()}, ${counter()}');

  // Anonymous function passed inline
  final doubled = [1, 2, 3].map((n) => n * 2).toList();
  print('anonymous fn via map: $doubled');
}
