void main() {
  // int - whole numbers
  int age = 25;

  // double - decimal numbers
  double height = 5.9;

  // String - text
  String name = "John";

  // bool - true or false
  bool isStudent = true;

  // List - ordered collection of items
  List<String> hobbies = ["reading", "coding", "gaming"];

  // Map - key-value pairs
  Map<String, dynamic> person = {
    "name": "John",
    "age": 25,
    "isStudent": true,
  };

  // Printing everything
  print('Name: $name');
  print('Age: $age');
  print('Height: $height');
  print('Is Student: $isStudent');
  print('Hobbies: $hobbies');
  print('Person Map: $person');

  // Accessing List items (index starts at 0)
  print('First hobby: ${hobbies[0]}');

  // Accessing Map values by key
  print('Person name from map: ${person["name"]}');


  ///// 1. Check Palindrome
  print('\nReal time examples');
  print('1. Check Palindrome');
  print(isPalindrome("madam")); // true
  print(isPalindrome("hello")); // false
  print('\n');

  ///// 2. Factorial
  print('2. Factorial');
  print(factorial(5)); // 120
  print('\n');

  ///// 3. Fibonacci Series
  print('3. Fibonacci Series');
  fibonacci(6); // 0 1 1 2 3 5
  print('\n');

  ///// 4. Check Prime Number
  print('4. Check Prime Number');
  print(isPrime(7));  // true
  print(isPrime(10)); // false
  print('\n');

  ///// 5. Swap Two Numbers (without a third variable)
  print('5. Swap Two Numbers (without a third variable)');
  swapNumbersWithoutThirdVariable();
  print('\n');

  ///// 6. Reverse a String
  print('6. Reverse a String');
  print(reverseString("flutter")); // rettulf
  print('\n');

  ///// 7. Find Largest Number in a List
  print('7. Find Largest Number in a List');
  print(findLargest([3, 7, 2, 9, 4])); // 9
  print('\n');

  ///// 8. Sum of Digits
  print('8. Sum of Digits');
  print(sumOfDigits(1234)); // 10
  print('\n');

  ///// 9. FizzBuzz
  print('9. FizzBuzz');
  fizzBuzz();
  print('\n');

  ///// 10. Bubble Sort
  List<int> numbers = [5, 2, 9, 1, 5, 6];
  bubbleSort(numbers);
  print(numbers); // [1, 2, 5, 5, 6, 9]
  print('\n');

  ///// 11. Check for Duplicates in a List
  print('11. Check for Duplicates in a List');
  print(hasDuplicates([1, 2, 3, 2])); // true
  print(hasDuplicates([1, 2, 3, 4])); // false

}

///// 1. Check Palindrome
bool isPalindrome(String s) {
  String reversed = s.split('').reversed.join('');
  return s == reversed;
}

///// 2. Factorial
int factorial(int n) {
  if (n == 0 || n == 1) return 1;
  return n * factorial(n - 1);
}

///// 3. Fibonacci Series
void fibonacci(int n) {
  int a = 0, b = 1;
  for (int i = 0; i < n; i++) {
    print(a);
    int next = a + b;
    a = b;
    b = next;
  }
}

///// 4. Check Prime Number
bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= n ~/ 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

///// 5. Swap Two Numbers (without a third variable)
void swapNumbersWithoutThirdVariable() {
  int a = 5, b = 10;
  a = a + b;
  b = a - b;
  a = a - b;
  print('a = $a, b = $b'); // a = 10, b = 5
}

///// 6. Reverse a String
String reverseString(String s) {
  return s.split('').reversed.join('');
}

///// 7. Find Largest Number in a List
int findLargest(List<int> numbers) {
  int max = numbers[0];
  for (int num in numbers) {
    if (num > max) max = num;
  }
  return max;
}

//// 8. Sum of Digits
int sumOfDigits(int n) {
  int sum = 0;
  while (n > 0) {
    sum += n % 10;
    n ~/= 10;
  }
  return sum;
}

///// 9. FizzBuzz
void fizzBuzz() {
  for (int i = 1; i <= 15; i++) {
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

///// 10. Bubble Sort
void bubbleSort(List<int> list) {
  int n = list.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (list[j] > list[j + 1]) {
        int temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
}


///// 11. Check for Duplicates in a List
bool hasDuplicates(List<int> list) {
  Set<int> seen = {};
  for (int num in list) {
    if (seen.contains(num)) return true;
    seen.add(num);
  }
  return false;
}