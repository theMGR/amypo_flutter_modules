import 'package:flutter/material.dart';

class FeeScreen extends StatefulWidget {
  @override
  _FeeScreenState createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  final TextEditingController _studentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fee Management")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/school_bg.jpg"), // background image
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // semi-transparent overlay for readability
          color: Colors.black.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _studentController,
                  decoration: InputDecoration(
                    labelText: "Student Name",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: "Amount Paid",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Saved: ${_studentController.text} - ₹${_amountController.text}",
                        ),
                      ),
                    );
                  },
                  child: Text("Save Fee"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
