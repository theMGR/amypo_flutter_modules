// Session 3 — Operators

void runOperators() {
  print('\n--- 03: Operators ---');

  int a = 10, b = 3;
  print('arithmetic: a+b=${a + b} a-b=${a - b} a*b=${a * b} a/b=${a / b} a~/b=${a ~/ b} a%b=${a % b}');

  print('relational: a>b=${a > b} a<=b=${a <= b} a==b=${a == b}');

  bool x = true, y = false;
  print('logical: x&&y=${x && y} x||y=${x || y} !x=${!x}');

  int c = 5;
  c += 4; // assignment operator
  print('assignment: c after += 4 is $c');

  // Null-aware operators
  String? maybeName;
  String displayName = maybeName ?? 'Guest'; // use default if null
  print('null-aware ??: displayName=$displayName');

  maybeName ??= 'Assigned Now'; // assign only if currently null
  print('null-aware ??=: maybeName=$maybeName');

  // Cascade operator: chain calls on the same object
  var buffer = StringBuffer()
    ..write('Hello')
    ..write(', ')
    ..write('Dart!');
  print('cascade: $buffer');
}
