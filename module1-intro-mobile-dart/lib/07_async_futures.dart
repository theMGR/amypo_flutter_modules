// Session 7 — Asynchronous programming and Futures

// Simulates a network call that resolves after a delay
Future<String> fetchUserName(int userId) async {
  await Future.delayed(const Duration(milliseconds: 200));
  if (userId <= 0) {
    throw ArgumentError('Invalid userId: $userId');
  }
  return 'User#$userId';
}

// Simulates a dependent second call (chaining)
Future<int> fetchUserScore(String userName) async {
  await Future.delayed(const Duration(milliseconds: 150));
  return userName.length * 10;
}

Future<void> demoAsyncAwait() async {
  final name = await fetchUserName(7);
  final score = await fetchUserScore(name);
  print('async/await: $name scored $score');
}

void demoThenCatchError() {
  fetchUserName(3)
      .then((name) => print('.then(): got $name'))
      .catchError((e) => print('.catchError(): $e'));
}

Future<void> demoErrorHandling() async {
  try {
    await fetchUserName(-1);
  } catch (e) {
    print('try/catch caught: $e');
  }
}

// Brief Stream intro: a sequence of async values over time
Stream<int> countdown(int from) async* {
  for (int i = from; i >= 0; i--) {
    await Future.delayed(const Duration(milliseconds: 100));
    yield i;
  }
}

Future<void> demoStream() async {
  await for (final tick in countdown(3)) {
    print('stream tick: $tick');
  }
}

Future<void> runAsyncFutures() async {
  print('\n--- 07: Async Programming & Futures ---');
  await demoAsyncAwait();
  demoThenCatchError();
  await demoErrorHandling();
  await demoStream();
  // give the .then()/.catchError() chain time to print before program exit
  await Future.delayed(const Duration(milliseconds: 300));
}
