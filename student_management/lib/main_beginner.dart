// ============================================================
// STUDENT MANAGEMENT APP — BEGINNER VERSION
// ============================================================
// This is a simple, single-file Flutter app for learning purposes.
// It has 3 screens:
//   1. Student List  -> shows all students
//   2. Add Student    -> a form to add a new student
//   3. Student Detail -> shows one student's full info
//
// Concepts used (all core Flutter basics):
//   - StatefulWidget + setState()   -> how the UI updates itself
//   - Navigator.push() / pop()      -> how to move between screens
//   - ListView.builder()            -> how to show a list of items
//   - TextEditingController         -> how to read text from a form
//   - A simple Dart class (Student) -> how to model your data
//
// No external packages, no custom fonts, no complex theming.
// This is intentionally plain so the structure is easy to follow.
// ============================================================

import 'package:flutter/material.dart';

// The entry point of every Flutter app.
void main() {
  runApp(const MyApp());
}

// ------------------------------------------------------------
// 1. THE APP ROOT
// ------------------------------------------------------------
// MyApp just sets up the overall app (title, theme, first screen).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      debugShowCheckedModeBanner: false, // hides the red "DEBUG" banner
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const StudentListScreen(), // the first screen shown
    );
  }
}

// ------------------------------------------------------------
// 2. THE DATA MODEL
// ------------------------------------------------------------
// A plain Dart class describing what one "Student" looks like.
// This is NOT a widget — it's just a data container.
class Student {
  final String name;
  final String rollNumber;
  final String studentClass;
  final String grade;

  Student({
    required this.name,
    required this.rollNumber,
    required this.studentClass,
    required this.grade,
  });
}

// ------------------------------------------------------------
// 3. SCREEN ONE: STUDENT LIST
// ------------------------------------------------------------
// This screen shows every student in a scrollable list.
// It is a StatefulWidget because the list of students can change
// (we add new students to it), and the screen needs to redraw
// itself whenever that happens.
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  // This list lives in memory only (it resets when the app restarts).
  // Start with a couple of sample students so the list isn't empty.
  final List<Student> _students = [
    Student(name: 'Ananya Raghunathan', rollNumber: '10B-14', studentClass: '10-B', grade: 'A-'),
    Student(name: 'Karthik Subramaniam', rollNumber: '10B-02', studentClass: '10-B', grade: 'B+'),
  ];

  // This function opens the "Add Student" screen and waits for a result.
  // When AddStudentScreen calls Navigator.pop(context, newStudent),
  // that newStudent value shows up here as `result`.
  Future<void> _openAddStudentScreen() async {
    final result = await Navigator.push<Student>(
      context,
      MaterialPageRoute(builder: (context) => const AddStudentScreen()),
    );

    // If the user actually saved a student (didn't just go back),
    // add it to our list and refresh the screen.
    if (result != null) {
      setState(() {
        _students.add(result);
      });
    }
  }

  // This function opens the detail screen for one student.
  void _openDetailScreen(Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentDetailScreen(student: student)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      // ListView.builder is efficient: it only builds the list items
      // that are currently visible on screen.
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(student.name[0]), // first letter of the name
              ),
              title: Text(student.name),
              subtitle: Text('Roll No: ${student.rollNumber} · Class ${student.studentClass}'),
              trailing: Text(
                student.grade,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () => _openDetailScreen(student),
            ),
          );
        },
      ),
      // Floating "+" button to add a new student.
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddStudentScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ------------------------------------------------------------
// 4. SCREEN TWO: ADD STUDENT (a simple form)
// ------------------------------------------------------------
class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  // Controllers let us read whatever text the user typed into each field.
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _classController = TextEditingController();
  final _gradeController = TextEditingController();

  // It's good practice to dispose controllers when the screen closes,
  // so Flutter can free up the memory they used.
  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _classController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    // Don't save if the name field is empty.
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name')),
      );
      return;
    }

    final newStudent = Student(
      name: _nameController.text.trim(),
      rollNumber: _rollController.text.trim(),
      studentClass: _classController.text.trim(),
      grade: _gradeController.text.trim().isEmpty ? '—' : _gradeController.text.trim(),
    );

    // Send the new student back to the previous screen (the list screen).
    Navigator.pop(context, newStudent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rollController,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _classController,
              decoration: const InputDecoration(
                labelText: 'Class / Section',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _gradeController,
              decoration: const InputDecoration(
                labelText: 'Grade (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveStudent,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('Save Student'),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// 5. SCREEN THREE: STUDENT DETAIL
// ------------------------------------------------------------
// This screen just displays the info of one student that was
// passed in from the list screen. It doesn't need to be
// "Stateful" because nothing on this screen ever changes.
class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                student.name[0],
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 20),
            _DetailRow(label: 'Name', value: student.name),
            _DetailRow(label: 'Roll Number', value: student.rollNumber),
            _DetailRow(label: 'Class', value: student.studentClass),
            _DetailRow(label: 'Grade', value: student.grade),
          ],
        ),
      ),
    );
  }
}

// A small reusable widget just to avoid repeating the same
// "label on top, value below" layout four times.
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
