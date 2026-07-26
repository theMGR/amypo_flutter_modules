// Session 4 — Control flow

void runControlFlow() {
  print('\n--- 04: Control Flow ---');

  // if / else if / else
  int score = 72;
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 70) {
    print('Grade: B');
  } else {
    print('Grade: C');
  }

  // switch
  String day = 'TUE';
  switch (day) {
    case 'MON':
      print('Start of week');
      break;
    case 'TUE':
    case 'WED':
    case 'THU':
      print('Midweek');
      break;
    case 'FRI':
      print('Almost weekend');
      break;
    default:
      print('Weekend');
  }

  // for loop
  for (int i = 1; i <= 3; i++) {
    print('for loop i=$i');
  }

  // for-in over a collection
  for (final lang in ['Dart', 'Java']) {
    print('for-in lang=$lang');
  }

  // while / do-while
  int n = 3;
  while (n > 0) {
    print('while n=$n');
    n--;
  }

  int m = 0;
  do {
    print('do-while m=$m');
    m++;
  } while (m < 2);

  // break / continue
  for (int i = 1; i <= 5; i++) {
    if (i == 2) continue; // skip 2
    if (i == 4) break; // stop at 4
    print('break/continue demo i=$i');
  }
}
