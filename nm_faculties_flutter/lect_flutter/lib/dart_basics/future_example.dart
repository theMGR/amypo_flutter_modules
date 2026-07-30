import 'main_dart_basics.dart';

void main() async {
  print('Start');

  String result1 = fetchData_1();
  print('result1 without future async: $result1');
  String result = await fetchData();
  print('result with future async: $result');


  print('End');



  // without async wait
  print('WITHOUT ASYNC WAIT');
  print('Start');

  fetchData().then((result) {
    print(result);
  });

  print('End');
}

String fetchData_1()  {
  // simulate delay, like a network call
  print('without future async');
  Future.delayed(Duration(seconds: 10));
  return 'Data loaded!';
}


Future<String> fetchData() async {
  // simulate delay, like a network call
  print('With Future async');
  await Future.delayed(Duration(seconds: 10));
  return 'Data loaded!';
}

class Student2 {
  void something() {
    var s = Student(1);
    // check to access private fields
    //s._
  }
}


