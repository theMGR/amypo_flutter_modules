import 'dart:io';

void main() {
  print("===== College Bus Tracking System =====");

  stdout.write("Enter Bus Number (1-5): ");
  int busNo = int.parse(stdin.readLineSync()!);

  switch (busNo) {
    case 1:
      print("\nBus No : 1");
      print("Route : Salem");
      print("Current Location : Bus Stand");
      print("Arrival Time : 10 Minutes");
      break;

    case 2:
      print("\nBus No : 2");
      print("Route : Namakkal");
      print("Current Location : Railway Station");
      print("Arrival Time : 5 Minutes");
      break;

    case 3:
      print("\nBus No : 3");
      print("Route : Rasipuram");
      print("Current Location : Main Road");
      print("Arrival Time : 8 Minutes");
      break;

    case 4:
      print("\nBus No : 4");
      print("Route : Tiruchengode");
      print("Current Location : Market");
      print("Arrival Time : 12 Minutes");
      break;

    case 5:
      print("\nBus No : 5");
      print("Route : Erode");
      print("Current Location : College Gate");
      print("Arrival Time : Arrived");
      break;

    default:
      print("\nInvalid Bus Number!");
  }
}