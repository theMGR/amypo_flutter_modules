import 'package:flutter/material.dart';

class MarksScreen extends StatefulWidget {
  @override
  _MarksScreenState createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  final TextEditingController _studentController = TextEditingController();
  final TextEditingController _marksController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String _selectedSubject = "Math";
  final List<String> _subjects = ["Math", "Science", "English", "History", "Computer"];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Marks")),
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
                DropdownButtonFormField<String>(
                  value: _selectedSubject,
                  items: _subjects.map((subject) {
                    return DropdownMenuItem(value: subject, child: Text(subject));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedSubject = val!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Select Subject",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _marksController,
                  decoration: InputDecoration(
                    labelText: "Marks",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: "Exam Date",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Saved: ${_studentController.text}, $_selectedSubject, Marks: ${_marksController.text}, Date: ${_dateController.text}",
                        ),
                      ),
                    );
                  },
                  child: Text("Save Marks"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
