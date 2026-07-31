import 'package:flutter/material.dart';

void main() {
  runApp(StudentApp());
}

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentScreen(),
    );
  }
}

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController deptController = TextEditingController();

  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: regController,
              decoration: InputDecoration(
                labelText: "Register Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: deptController,
              decoration: InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                setState(() {

                  result =
                  "Name : ${nameController.text}\n"
                      "Register No : ${regController.text}\n"
                      "Department : ${deptController.text}";

                });

              },

              child: Text("Show Details"),
            ),

            SizedBox(height: 20),

            Text(
              result,
              style: TextStyle(
                fontSize: 18,
              ),
            )

          ],
        ),
      ),
    );
  }
}