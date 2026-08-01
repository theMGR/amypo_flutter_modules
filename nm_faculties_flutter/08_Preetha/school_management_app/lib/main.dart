import 'package:flutter/material.dart';
import 'screens/dashboard.dart';
import 'screens/attendance.dart';
import 'screens/fees.dart';
import 'screens/marks.dart';
import 'screens/personal_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Named Routes setup
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/attendance': (context) => AttendanceScreen(),
        '/fees': (context) => FeeScreen(),
        '/marks': (context) => MarksScreen(),
        '/info': (context) => PersonalInfoScreen(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),      // comes from lib/screens/dashboard.dart
    AttendanceScreen(),
    FeeScreen(),
    MarksScreen(),
    PersonalInfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Fees'),
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Marks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Info'),
        ],
      ),
    );
  }
}
