// Session 6 — Classes & objects (OOP)

abstract class Vehicle {
  final String brand;
  int _speed = 0; // private field (leading underscore)

  Vehicle(this.brand); // constructor shorthand: this.brand

  int get speed => _speed; // getter
  set speed(int value) => _speed = value < 0 ? 0 : value; // setter with validation

  void accelerate(int amount) {
    speed = _speed + amount;
  }

  String describe(); // abstract method — subclasses must implement
}

class Car extends Vehicle {
  final int doors;

  Car(String brand, {this.doors = 4}) : super(brand);

  @override
  String describe() => '$brand car with $doors doors, currently at ${speed}km/h';
}

class Bike extends Vehicle {
  Bike(String brand) : super(brand);

  @override
  String describe() => '$brand bike, currently at ${speed}km/h';
}

// Mixin: reusable behavior added with `with`
mixin Honkable {
  String honk() => 'Beep beep!';
}

class SportsCar extends Car with Honkable {
  SportsCar(String brand) : super(brand, doors: 2);
}

void runClassesAndObjects() {
  print('\n--- 06: Classes & Objects ---');

  final car = Car('Toyota');
  car.accelerate(40);
  print(car.describe());

  final bike = Bike('Trek');
  bike.accelerate(15);
  print(bike.describe());

  final sports = SportsCar('Ferrari');
  sports.accelerate(120);
  print('${sports.describe()} — ${sports.honk()}');

  // Polymorphism: treat both as Vehicle
  final List<Vehicle> fleet = [car, bike, sports];
  for (final v in fleet) {
    print('fleet item: ${v.describe()}');
  }
}
