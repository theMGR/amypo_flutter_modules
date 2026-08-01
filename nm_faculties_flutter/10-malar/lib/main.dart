import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class BankAccount {
  String accountHolder;
  int accountNumber;
  double balance;

  BankAccount(this.accountHolder, this.accountNumber, this.balance);

  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
    }
  }

  void withdraw(double amount) {
    if (amount > 0 && amount <= balance) {
      balance -= amount;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bank Management",
      home: const BankPage(),
    );
  }
}

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final nameController = TextEditingController();
  final accController = TextEditingController();
  final amountController = TextEditingController();

  BankAccount? account;
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank Management System"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration:
              const InputDecoration(labelText: "Account Holder"),
            ),
            TextField(
              controller: accController,
              keyboardType: TextInputType.number,
              decoration:
              const InputDecoration(labelText: "Account Number"),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Initial Balance / Amount"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  account = BankAccount(
                    nameController.text,
                    int.parse(accController.text),
                    double.parse(amountController.text),
                  );
                  message = "Account Created Successfully";
                });
              },
              child: const Text("Create Account"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: account == null
                  ? null
                  : () {
                double amount =
                double.parse(amountController.text);
                setState(() {
                  account!.deposit(amount);
                  message = "₹$amount Deposited";
                });
              },
              child: const Text("Deposit"),
            ),
            ElevatedButton(
              onPressed: account == null
                  ? null
                  : () {
                double amount =
                double.parse(amountController.text);
                setState(() {
                  if (amount <= account!.balance) {
                    account!.withdraw(amount);
                    message = "₹$amount Withdrawn";
                  } else {
                    message = "Insufficient Balance";
                  }
                });
              },
              child: const Text("Withdraw"),
            ),
            const SizedBox(height: 20),
            if (account != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text("Name: ${account!.accountHolder}",
                          style: const TextStyle(fontSize: 18)),
                      Text("Account No: ${account!.accountNumber}",
                          style: const TextStyle(fontSize: 18)),
                      Text(
                        "Balance: ₹${account!.balance.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}