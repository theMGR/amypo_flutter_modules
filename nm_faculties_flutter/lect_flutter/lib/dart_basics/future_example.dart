import 'main_dart_basics.dart';

void main() async {
  print('Start');

  String result = await fetchData();
  print(result);

  print('End');



  // without async wait
  print('WITHOUT ASYNC WAIT');
  print('Start');

  fetchData().then((result) {
    print(result);
  });

  print('End');
}

Future<String> fetchData() async {
  // simulate delay, like a network call
  await Future.delayed(Duration(seconds: 2));
  return 'Data loaded!';
}

class Student2 {
  void something() {
    var s = Student(1);
    // check to access private fields
    //s._
  }
}


