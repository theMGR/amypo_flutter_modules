import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _studentController = TextEditingController();
  String _status = "Present";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
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
                DropdownButton<String>(
                  value: _status,
                  items: ["Present", "Absent"].map((val) {
                    return DropdownMenuItem(value: val, child: Text(val));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _status = val!;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Saved: ${_studentController.text} - $_status",
                        ),
                      ),
                    );
                  },
                  child: Text("Save Attendance"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
