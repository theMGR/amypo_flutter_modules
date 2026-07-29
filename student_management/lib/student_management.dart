// Classroom — student management
// Single-file Flutter app built from a small set of reusable widgets:
// InitialsAvatar, PillBadge, StatCard, SectionLabel, InfoCard/InfoRow,
// StudentListTile, PrimaryButton, LabeledField, and AppShell (bottom nav).
//
// Run: flutter create classroom && replace lib/main.dart with this file,
// then `flutter run`.

import 'package:flutter/material.dart';

void main() => runApp(const ClassroomApp());

// ---------------------------------------------------------------------------
// THEME TOKENS
// ---------------------------------------------------------------------------

class AppColors {
  static const ink = Color(0xFF1C2027);
  static const inkSoft = Color(0xFF5A6270);
  static const inkMute = Color(0xFF9298A3);
  static const paper = Color(0xFFF4F2EE);
  static const card = Color(0xFFFFFFFF);
  static const line = Color(0xFFE6E3DC);

  static const moss = Color(0xFF3F5D4E);
  static const mossSoft = Color(0xFFE7EDE9);
  static const clay = Color(0xFFB5603F);
  static const claySoft = Color(0xFFF4E3DA);
  static const amber = Color(0xFFA9772F);
  static const amberSoft = Color(0xFFF6ECD9);
  static const red = Color(0xFFA23B3B);
  static const redSoft = Color(0xFFF5E0E0);
}

const _radius = 14.0;

class ClassroomApp extends StatelessWidget {
  const ClassroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.moss,
          primary: AppColors.moss,
          surface: AppColors.paper,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.ink),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.card,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.line),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.line),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.moss, width: 2),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}

// ---------------------------------------------------------------------------
// DATA MODEL + SAMPLE DATA
// ---------------------------------------------------------------------------

class Student {
  final String name;
  final String initials;
  final String grade;
  final String roll;
  final int attendance;
  final String avgGrade;
  final String guardianPhone;
  final String email;
  final String dob;
  final Map<String, int> grades;
  final Color tint;
  final Color tintText;

  const Student({
    required this.name,
    required this.initials,
    required this.grade,
    required this.roll,
    required this.attendance,
    required this.avgGrade,
    required this.guardianPhone,
    required this.email,
    required this.dob,
    required this.grades,
    required this.tint,
    required this.tintText,
  });

  Color get statusColor {
    if (attendance >= 85) return AppColors.moss;
    if (attendance >= 75) return AppColors.amber;
    return AppColors.red;
  }

  Color get statusBg {
    if (attendance >= 85) return AppColors.mossSoft;
    if (attendance >= 75) return AppColors.amberSoft;
    return AppColors.redSoft;
  }
}

final List<Student> sampleStudents = [
  Student(
    name: 'Aditi Kumar',
    initials: 'AK',
    grade: 'Grade 9-A',
    roll: 'Roll 12',
    attendance: 96,
    avgGrade: 'A-',
    guardianPhone: '+91 98765 43210',
    email: 'aditi.k@school.edu',
    dob: '14 Mar 2011',
    grades: {'Mathematics': 92, 'Science': 88, 'English': 85},
    tint: AppColors.mossSoft,
    tintText: AppColors.moss,
  ),
  Student(
    name: 'Rahul Sharma',
    initials: 'RS',
    grade: 'Grade 9-A',
    roll: 'Roll 13',
    attendance: 78,
    avgGrade: 'B',
    guardianPhone: '+91 91234 56789',
    email: 'rahul.s@school.edu',
    dob: '02 Jul 2011',
    grades: {'Mathematics': 74, 'Science': 80, 'English': 77},
    tint: AppColors.claySoft,
    tintText: AppColors.clay,
  ),
  Student(
    name: 'Priya Menon',
    initials: 'PM',
    grade: 'Grade 8-B',
    roll: 'Roll 04',
    attendance: 91,
    avgGrade: 'A',
    guardianPhone: '+91 99887 66554',
    email: 'priya.m@school.edu',
    dob: '21 Nov 2011',
    grades: {'Mathematics': 90, 'Science': 93, 'English': 89},
    tint: AppColors.amberSoft,
    tintText: AppColors.amber,
  ),
  Student(
    name: 'Sanjay Verma',
    initials: 'SV',
    grade: 'Grade 10-C',
    roll: 'Roll 27',
    attendance: 64,
    avgGrade: 'C+',
    guardianPhone: '+91 90909 80808',
    email: 'sanjay.v@school.edu',
    dob: '09 Jan 2010',
    grades: {'Mathematics': 61, 'Science': 66, 'English': 70},
    tint: AppColors.redSoft,
    tintText: AppColors.red,
  ),
  Student(
    name: 'Neha Reddy',
    initials: 'NR',
    grade: 'Grade 8-B',
    roll: 'Roll 05',
    attendance: 88,
    avgGrade: 'A-',
    guardianPhone: '+91 93332 11009',
    email: 'neha.r@school.edu',
    dob: '30 Aug 2011',
    grades: {'Mathematics': 84, 'Science': 87, 'English': 90},
    tint: AppColors.mossSoft,
    tintText: AppColors.moss,
  ),
];

// ---------------------------------------------------------------------------
// COMMON / REUSABLE WIDGETS
// ---------------------------------------------------------------------------

/// Circular initials avatar, tinted per-student.
class InitialsAvatar extends StatelessWidget {
  final String initials;
  final Color background;
  final Color foreground;
  final double size;

  const InitialsAvatar({
    super.key,
    required this.initials,
    this.background = AppColors.mossSoft,
    this.foreground = AppColors.moss,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: background,
      child: Text(
        initials,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w600,
          fontSize: size * 0.34,
        ),
      ),
    );
  }
}

/// Small rounded status badge, e.g. "96% present".
class PillBadge extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;

  const PillBadge({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// A metric tile used on Home and Student detail (e.g. "Attendance · 96%").
class StatCard extends StatelessWidget {
  final String label;
  final String value;

  const StatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.line),
          borderRadius: BorderRadius.circular(_radius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.inkSoft)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

/// Small uppercase section heading ("CONTACT", "RECENT GRADES"...).
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w600,
          color: AppColors.inkMute,
        ),
      ),
    );
  }
}

/// Card wrapper that hosts a list of InfoRow/rows with dividers.
class InfoCard extends StatelessWidget {
  final List<Widget> children;
  const InfoCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++)
            Container(
              decoration: BoxDecoration(
                border: i < children.length - 1
                    ? const Border(bottom: BorderSide(color: AppColors.line))
                    : null,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: children[i],
            ),
        ],
      ),
    );
  }
}

/// One key/value line inside an InfoCard, e.g. "Guardian → +91 ...".
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLink;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.inkSoft),
            const SizedBox(width: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 13, color: AppColors.inkSoft)),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isLink ? AppColors.moss : AppColors.ink,
          ),
        ),
      ],
    );
  }
}

/// A student row for list screens — avatar, name/meta, status pill.
class StudentListTile extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;

  const StudentListTile({super.key, required this.student, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            InitialsAvatar(
              initials: student.initials,
              background: student.tint,
              foreground: student.tintText,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text('${student.grade} · ${student.roll}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.inkSoft)),
                ],
              ),
            ),
            PillBadge(
              label: '${student.attendance}% present',
              background: student.statusBg,
              foreground: student.statusColor,
            ),
          ],
        ),
      ),
    );
  }
}

/// Full-width primary action button.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.moss,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
        child: Text(label,
            style:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

/// Labeled input field wrapper used throughout the add-student form.
class LabeledField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextInputType keyboardType;
  final Widget? child;

  const LabeledField({
    super.key,
    required this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: AppColors.inkSoft,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        child ??
            TextField(
              keyboardType: keyboardType,
              decoration: InputDecoration(hintText: hint),
            ),
      ],
    );
  }
}

/// Horizontally scrolling filter chips (e.g. grade filters).
class FilterChips extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  const FilterChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final opt = options[i];
          final active = opt == selected;
          return ChoiceChip(
            label: Text(opt),
            selected: active,
            onSelected: (_) => onSelected(opt),
            labelStyle: TextStyle(
              fontSize: 12,
              color: active ? Colors.white : AppColors.inkSoft,
            ),
            selectedColor: AppColors.moss,
            backgroundColor: AppColors.card,
            side: BorderSide(color: active ? AppColors.moss : AppColors.line),
            shape: const StadiumBorder(),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// APP SHELL — bottom navigation across the four tabs
// ---------------------------------------------------------------------------

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  void _goTo(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomeScreen(onNavigate: _goTo),
      const StudentsScreen(),
      const AttendanceScreen(),
      const AccountScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: tabs[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _goTo,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.moss,
        unselectedItemColor: AppColors.inkMute,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        backgroundColor: AppColors.card,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Students'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN: HOME
// ---------------------------------------------------------------------------

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final atRisk = sampleStudents.where((s) => s.attendance < 85).toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good morning, Ms. Rao',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 3),
                  Text('Wednesday, 29 July',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.inkSoft)),
                ],
              ),
              const Icon(Icons.notifications_none, color: AppColors.ink),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Row(
            children: [
              StatCard(label: 'Total students', value: '128'),
              SizedBox(width: 10),
              StatCard(label: 'Present today', value: '119'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionLabel('Quick actions'),
        InfoCard(children: [
          InkWell(
            onTap: () => onNavigate(2),
            child: Row(
              children: [
                const InitialsAvatar(
                  initials: '',
                  background: AppColors.mossSoft,
                  foreground: AppColors.moss,
                  size: 36,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mark today\'s attendance',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      Text('Grade 9-A · not yet taken',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.inkSoft)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.inkMute),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddStudentScreen())),
            child: Row(
              children: [
                const InitialsAvatar(
                  initials: '',
                  background: AppColors.claySoft,
                  foreground: AppColors.clay,
                  size: 36,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enroll a new student',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      Text('Add profile and contact info',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.inkSoft)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.inkMute),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 18),
        const SectionLabel('Needs attention'),
        InfoCard(
          children: atRisk
              .map((s) => InfoRow(
                    icon: Icons.warning_amber_rounded,
                    label: s.name,
                    value: '${s.attendance}% attendance',
                  ))
              .toList(),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN: STUDENTS (roster)
// ---------------------------------------------------------------------------

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String _filter = 'All';
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = sampleStudents.where((s) {
      final matchesFilter = _filter == 'All' || s.grade.startsWith(_filter);
      final matchesQuery =
          s.name.toLowerCase().contains(_query.toLowerCase());
      return matchesFilter && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.clay,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AddStudentScreen())),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Students',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddStudentScreen())),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                hintText: 'Search by name or roll no',
                prefixIcon: Icon(Icons.search, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilterChips(
            options: const ['All', 'Grade 8', 'Grade 9', 'Grade 10'],
            selected: _filter,
            onSelected: (v) => setState(() => _filter = v),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: filtered
                  .map((s) => StudentListTile(
                        student: s,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => StudentDetailScreen(student: s)),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN: STUDENT DETAIL (pushed from a roster tap)
// ---------------------------------------------------------------------------

class StudentDetailScreen extends StatelessWidget {
  final Student student;
  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.ink),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.edit_outlined, color: AppColors.ink),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Column(
            children: [
              InitialsAvatar(
                initials: student.initials,
                background: AppColors.mossSoft,
                foreground: AppColors.moss,
                size: 72,
              ),
              const SizedBox(height: 10),
              Text(student.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text('${student.grade} · ${student.roll}',
                  style:
                      const TextStyle(fontSize: 13, color: AppColors.inkSoft)),
              const SizedBox(height: 18),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                StatCard(label: 'Attendance', value: '${student.attendance}%'),
                const SizedBox(width: 10),
                StatCard(label: 'Avg. grade', value: student.avgGrade),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const SectionLabel('Contact'),
          InfoCard(children: [
            InfoRow(icon: Icons.call_outlined, label: 'Guardian', value: student.guardianPhone),
            InfoRow(icon: Icons.mail_outline, label: 'Email', value: student.email, isLink: true),
            InfoRow(icon: Icons.cake_outlined, label: 'DOB', value: student.dob),
          ]),
          const SizedBox(height: 18),
          const SectionLabel('Recent grades'),
          InfoCard(
            children: student.grades.entries
                .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key, style: const TextStyle(fontSize: 13)),
                        Text('${e.value}',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN: ATTENDANCE
// ---------------------------------------------------------------------------

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

enum _Mark { present, absent, unmarked }

class _AttendanceScreenState extends State<AttendanceScreen> {
  String _section = 'Grade 9-A';
  final Map<String, _Mark> _marks = {
    'Aditi Kumar': _Mark.present,
    'Rahul Sharma': _Mark.absent,
    'Priya Menon': _Mark.present,
    'Sanjay Verma': _Mark.unmarked,
  };

  void _toggle(String name) {
    setState(() {
      final current = _marks[name] ?? _Mark.unmarked;
      _marks[name] = _Mark
          .values[(current.index + 1) % _Mark.values.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    final marked = _marks.values.where((m) => m != _Mark.unmarked).length;

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Attendance',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              Icon(Icons.calendar_today_outlined, color: AppColors.ink),
            ],
          ),
        ),
        FilterChips(
          options: const ['Grade 9-A', 'Grade 9-B', 'Grade 10-C'],
          selected: _section,
          onSelected: (v) => setState(() => _section = v),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text('29 Jul 2026 · $marked of ${_marks.length} marked',
              style: const TextStyle(fontSize: 12, color: AppColors.inkSoft)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: sampleStudents.take(4).map((s) {
              final mark = _marks[s.name] ?? _Mark.unmarked;
              final Color bg, fg;
              final IconData icon;
              switch (mark) {
                case _Mark.present:
                  bg = AppColors.mossSoft;
                  fg = AppColors.moss;
                  icon = Icons.check;
                  break;
                case _Mark.absent:
                  bg = AppColors.redSoft;
                  fg = AppColors.red;
                  icon = Icons.close;
                  break;
                case _Mark.unmarked:
                  bg = AppColors.card;
                  fg = AppColors.inkMute;
                  icon = Icons.remove;
                  break;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  children: [
                    InitialsAvatar(
                        initials: s.initials,
                        background: s.tint,
                        foreground: s.tintText),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.name,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          Text(s.roll,
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.inkSoft)),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => _toggle(s.name),
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: bg,
                          border: Border.all(color: fg),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 16, color: fg),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: PrimaryButton(
            label: 'Save attendance',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attendance saved')),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN: ACCOUNT (the teacher/admin's own profile)
// ---------------------------------------------------------------------------

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              Icon(Icons.settings_outlined, color: AppColors.ink),
            ],
          ),
        ),
        Column(
          children: const [
            InitialsAvatar(
              initials: 'SR',
              background: AppColors.claySoft,
              foreground: AppColors.clay,
              size: 72,
            ),
            SizedBox(height: 10),
            Text('Sunita Rao',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 3),
            Text('Class teacher · Grade 9-A',
                style: TextStyle(fontSize: 13, color: AppColors.inkSoft)),
            SizedBox(height: 18),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Row(
            children: [
              StatCard(label: 'Classes', value: '3'),
              SizedBox(width: 10),
              StatCard(label: 'Students', value: '128'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionLabel('Account'),
        InfoCard(children: [
          _accountLink(Icons.person_outline, 'Personal details'),
          _accountLink(Icons.notifications_none, 'Notifications'),
          _accountLink(Icons.lock_outline, 'Privacy and security'),
          _accountLink(Icons.logout, 'Log out', showChevron: false),
        ]),
      ],
    );
  }

  Widget _accountLink(IconData icon, String label, {bool showChevron = true}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.inkSoft),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        if (showChevron)
          const Icon(Icons.chevron_right, color: AppColors.inkMute),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN: ADD / EDIT STUDENT (pushed via fab or quick action)
// ---------------------------------------------------------------------------

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  String _grade = 'Grade 8';
  String _section = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.ink),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add student',
            style: TextStyle(fontSize: 16, color: AppColors.ink)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.inkMute, width: 1.5),
              ),
              child: const Icon(Icons.camera_alt_outlined,
                  color: AppColors.inkMute),
            ),
          ),
          const SizedBox(height: 18),
          const LabeledField(label: 'Full name', hint: 'e.g. Neha Reddy'),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: LabeledField(
                  label: 'Grade',
                  child: DropdownButtonFormField<String>(
                    value: _grade,
                    items: const ['Grade 8', 'Grade 9', 'Grade 10']
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (v) => setState(() => _grade = v!),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LabeledField(
                  label: 'Section',
                  child: DropdownButtonFormField<String>(
                    value: _section,
                    items: const ['A', 'B', 'C']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setState(() => _section = v!),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const LabeledField(label: 'Roll number', hint: 'e.g. 21'),
          const SizedBox(height: 14),
          const LabeledField(
            label: 'Date of birth',
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Select date',
                suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const LabeledField(
              label: 'Guardian phone',
              hint: '+91 90000 00000',
              keyboardType: TextInputType.phone),
          const SizedBox(height: 14),
          const LabeledField(
              label: 'Email',
              hint: 'name@school.edu',
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'Save student',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Student saved')),
              );
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(fontSize: 12, color: AppColors.inkMute)),
            ),
          ),
        ],
      ),
    );
  }
}
