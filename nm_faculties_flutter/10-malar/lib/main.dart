import 'dart:io';


class BankAccount {
  String accountHolder;
  int accountNumber;
  double balance;

  BankAccount(this.accountHolder, this.accountNumber, this.balance);

  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print("₹$amount deposited successfully.");
    } else {
      print("Invalid deposit amount.");
    }
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
    } else if (amount > balance) {
      print("Insufficient balance.");
    } else {
      balance -= amount;
      print("₹$amount withdrawn successfully.");
    }
  }

  void showDetails() {
    print("\n------ Account Details ------");
    print("Account Holder : $accountHolder");
    print("Account Number : $accountNumber");
    print("Balance        : ₹${balance.toStringAsFixed(2)}");
    print("-----------------------------");
  }
}

void main() {
  print("===== BANK MANAGEMENT SYSTEM =====");

  stdout.write("Enter Account Holder Name: ");
  String name = stdin.readLineSync()!;

  stdout.write("Enter Account Number: ");
  int accNo = int.parse(stdin.readLineSync()!);

  stdout.write("Enter Initial Deposit: ");
  double initialBalance = double.parse(stdin.readLineSync()!);

  BankAccount account = BankAccount(name, accNo, initialBalance);

  while (true) {
    print("\n===== MENU =====");
    print("1. Deposit");
    print("2. Withdraw");
    print("3. Check Balance");
    print("4. Exit");

    stdout.write("Enter your choice: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write("Enter deposit amount: ");
        double amount = double.parse(stdin.readLineSync()!);
        account.deposit(amount);
        break;

      case 2:
        stdout.write("Enter withdrawal amount: ");
        double amount = double.parse(stdin.readLineSync()!);
        account.withdraw(amount);
        break;

      case 3:
        account.showDetails();
        break;

      case 4:
        print("Thank you for using the Bank Management System!");
        return;

      default:
        print("Invalid choice. Please try again.");
    }
  }
}