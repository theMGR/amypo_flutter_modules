// Register — Student Management
// Single-file Flutter app. Drop into lib/main.dart of any Flutter project.
// No third-party packages required.

import 'package:flutter/material.dart';

void main() => runApp(const RegisterApp());

// ───────────────────────── THEME ─────────────────────────

class AppColors {
  static const ink = Color(0xFF1E2A38);
  static const paper = Color(0xFFF4EFE1);
  static const paperRaised = Color(0xFFFFFDF8);
  static const brass = Color(0xFFA97C3F);
  static const brassSoft = Color(0xFFD9C39A);
  static const sage = Color(0xFF5D7A5D);
  static const sageBg = Color(0xFFE7EEE4);
  static const rust = Color(0xFFA84A3B);
  static const rustBg = Color(0xFFF3E4DF);
  static const slate = Color(0xFF6B7280);
  static const line = Color(0xFFD8CFB8);
  static const amberBg = Color(0xFFF1E6C8);
  static const amberText = Color(0xFF8A6A1F);
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.brass,
          primary: AppColors.brass,
          surface: AppColors.paperRaised,
        ),
        fontFamily: 'Georgia', // stand-in serif; swap for Fraunces via google_fonts if desired
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      home: const HomeShell(),
    );
  }
}

// ───────────────────────── DATA ─────────────────────────

class Student {
  final String name;
  final String roll;
  final String initials;
  final int attendancePct;
  final String grade;
  final String status; // Active, On leave, Fee overdue

  const Student({
    required this.name,
    required this.roll,
    required this.initials,
    required this.attendancePct,
    required this.grade,
    required this.status,
  });
}

const List<Student> kStudents = [
  Student(name: 'Ananya Raghunathan', roll: '10B-14', initials: 'AR', attendancePct: 96, grade: 'A-', status: 'Active'),
  Student(name: 'Karthik Subramaniam', roll: '10B-02', initials: 'KS', attendancePct: 91, grade: 'B+', status: 'Active'),
  Student(name: 'Meera Iyer', roll: '10B-27', initials: 'MI', attendancePct: 78, grade: 'B', status: 'On leave'),
  Student(name: 'Divya Prakash', roll: '10B-09', initials: 'DP', attendancePct: 94, grade: 'A', status: 'Active'),
  Student(name: 'Rohan Bhat', roll: '10B-31', initials: 'RB', attendancePct: 85, grade: 'C+', status: 'Fee overdue'),
  Student(name: 'Sanjana Rao', roll: '10B-18', initials: 'SR', attendancePct: 89, grade: 'C', status: 'Active'),
];

// ───────────────────────── SHELL / NAV ─────────────────────────

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  Student _selectedStudent = kStudents.first;
  final Map<String, String> _attendance = {
    for (final s in kStudents) s.roll: 'Present',
  };

  void _openProfile(Student s) {
    setState(() {
      _selectedStudent = s;
      _index = 2;
    });
  }

  void _setAttendance(String roll, String status) {
    setState(() => _attendance[roll] = status);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(onOpenProfile: _openProfile),
      StudentsScreen(onOpenProfile: _openProfile),
      ProfileScreen(student: _selectedStudent),
      AttendanceScreen(attendance: _attendance, onSetStatus: _setAttendance),
      const GradesScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _index, children: pages)),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.ink,
          border: Border(top: BorderSide(color: Color(0x24EFE7D2))),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                _NavItem(icon: Icons.grid_view_rounded, label: 'Dashboard', selected: _index == 0, onTap: () => setState(() => _index = 0)),
                _NavItem(icon: Icons.groups_rounded, label: 'Students', selected: _index == 1, onTap: () => setState(() => _index = 1)),
                _NavItem(icon: Icons.person_rounded, label: 'Profile', selected: _index == 2, onTap: () => setState(() => _index = 2)),
                _NavItem(icon: Icons.fact_check_rounded, label: 'Attend.', selected: _index == 3, onTap: () => setState(() => _index = 3)),
                _NavItem(icon: Icons.bar_chart_rounded, label: 'Grades', selected: _index == 4, onTap: () => setState(() => _index = 4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.brassSoft : const Color(0xFF9AA3AE);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected)
              Container(width: 18, height: 2.5, margin: const EdgeInsets.only(bottom: 4), decoration: BoxDecoration(color: AppColors.brass, borderRadius: BorderRadius.circular(2)))
            else
              const SizedBox(height: 6.5),
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── SHARED WIDGETS ─────────────────────────

class TopBar extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final VoidCallback? onBack;

  const TopBar({super.key, required this.eyebrow, required this.title, this.subtitle, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 15),
      decoration: const BoxDecoration(
        color: AppColors.paperRaised,
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          if (onBack != null) ...[
            InkWell(
              onTap: onBack,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.line), color: AppColors.paper),
                child: const Icon(Icons.arrow_back, size: 16, color: AppColors.ink),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eyebrow.toUpperCase(), style: const TextStyle(fontSize: 10, letterSpacing: 1.2, color: AppColors.brass, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(title, style: const TextStyle(fontFamily: 'Georgia', fontSize: 21, fontWeight: FontWeight.w700, color: AppColors.ink)),
                if (subtitle != null) ...[
                  const SizedBox(height: 3),
                  Text(subtitle!, style: const TextStyle(fontSize: 12, color: AppColors.slate)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionPanel extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const SectionPanel({super.key, required this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.paperRaised,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.line))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontFamily: 'Georgia', fontSize: 15.5, fontWeight: FontWeight.w700, color: AppColors.ink)),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(15, 6, 15, 12), child: child),
        ],
      ),
    );
  }
}

class Stamp extends StatelessWidget {
  final String text;
  final String kind; // present, absent, late

  const Stamp({super.key, required this.text, required this.kind});

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (kind) {
      case 'absent':
        bg = AppColors.rustBg; fg = AppColors.rust; break;
      case 'late':
        bg = AppColors.amberBg; fg = AppColors.amberText; break;
      default:
        bg = AppColors.sageBg; fg = AppColors.sage;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20), border: Border.all(color: fg, width: 1.2)),
      child: Text(text, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

class RollBadge extends StatelessWidget {
  final String roll;
  const RollBadge({super.key, required this.roll});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(4)),
      child: Text(roll, style: const TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: AppColors.brassSoft)),
    );
  }
}

// ───────────────────────── DASHBOARD ─────────────────────────

class DashboardScreen extends StatelessWidget {
  final void Function(Student) onOpenProfile;
  const DashboardScreen({super.key, required this.onOpenProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBar(eyebrow: 'Overview', title: 'Dashboard', subtitle: 'Wed, 29 July 2026 · Grade 10-B'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.5,
                children: const [
                  _StatCard(label: 'Students', value: '148', delta: '+3 this term', good: true),
                  _StatCard(label: 'Present Today', value: '92%', delta: '+1.4% vs last wk', good: true),
                  _StatCard(label: 'Avg. Grade', value: 'B+', delta: '78.4 / 100', good: true),
                  _StatCard(label: 'Fee Dues', value: '₹1.2L', delta: '11 pending', good: false),
                ],
              ),
              const SizedBox(height: 4),
              SectionPanel(
                title: 'Recent Entries',
                trailing: const Text('TODAY', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: AppColors.slate)),
                child: Column(
                  children: [
                    _LedgerRow(roll: '10B-14', name: 'Ananya Raghunathan', note: 'Marked late arrival · 9:14 AM', stamp: 'Late', kind: 'late'),
                    _LedgerRow(roll: '10B-02', name: 'Karthik Subramaniam', note: 'Submitted science project · 9:02 AM', stamp: 'Logged', kind: 'present'),
                    _LedgerRow(roll: '10B-27', name: 'Meera Iyer', note: 'Medical leave · 8:45 AM', stamp: 'Absent', kind: 'absent', isLast: true),
                  ],
                ),
              ),
              SectionPanel(
                title: 'Attention Needed',
                child: Column(
                  children: const [
                    _LedgerRow(roll: '10B-27', name: 'Meera Iyer', note: '3 absences this month', stamp: 'Review', kind: 'absent'),
                    _LedgerRow(roll: '10B-31', name: 'Rohan Bhat', note: 'Fee payment overdue', stamp: 'Overdue', kind: 'late', isLast: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value, delta;
  final bool good;
  const _StatCard({required this.label, required this.value, required this.delta, required this.good});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.paperRaised,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.line),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 2, offset: Offset(0, 1))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 3, width: 28, decoration: BoxDecoration(color: AppColors.brass, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 8),
          Text(label.toUpperCase(), style: const TextStyle(fontSize: 10.5, letterSpacing: .6, color: AppColors.slate)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontFamily: 'Georgia', fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 2),
          Text(delta, style: TextStyle(fontSize: 11, color: good ? AppColors.sage : AppColors.rust, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _LedgerRow extends StatelessWidget {
  final String roll, name, note, stamp, kind;
  final bool isLast;
  const _LedgerRow({required this.roll, required this.name, required this.note, required this.stamp, required this.kind, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.line, width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [RollBadge(roll: '#$roll'), Stamp(text: stamp, kind: kind)],
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.ink)),
          Text(note, style: const TextStyle(fontSize: 11.5, color: AppColors.slate)),
        ],
      ),
    );
  }
}

// ───────────────────────── STUDENTS ─────────────────────────

class StudentsScreen extends StatelessWidget {
  final void Function(Student) onOpenProfile;
  const StudentsScreen({super.key, required this.onOpenProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBar(eyebrow: 'Records', title: 'Students', subtitle: '148 enrolled · Grade 10-B roster'),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(color: AppColors.paperRaised, border: Border.all(color: AppColors.line), borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.search, size: 18, color: AppColors.slate),
              SizedBox(width: 8),
              Text('Search name or roll number…', style: TextStyle(color: AppColors.slate, fontSize: 13.5)),
            ]),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: kStudents.length,
            itemBuilder: (context, i) {
              final s = kStudents[i];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.paperRaised,
                  border: Border(bottom: i == kStudents.length - 1 ? BorderSide.none : const BorderSide(color: AppColors.line)),
                  borderRadius: i == 0
                      ? const BorderRadius.vertical(top: Radius.circular(8))
                      : i == kStudents.length - 1
                      ? const BorderRadius.vertical(bottom: Radius.circular(8))
                      : BorderRadius.zero,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onOpenProfile(s),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(radius: 19, backgroundColor: AppColors.brass, child: Text(s.initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Georgia'))),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(s.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink)),
                                const SizedBox(height: 2),
                                Row(children: [RollBadge(roll: s.roll), const SizedBox(width: 6), Text('· ${s.status}', style: const TextStyle(fontSize: 11.5, color: AppColors.slate))]),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(s.grade, style: const TextStyle(fontFamily: 'Georgia', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
                              Text('${s.attendancePct}% attend.', style: const TextStyle(fontSize: 10.5, color: AppColors.slate)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── PROFILE ─────────────────────────

class ProfileScreen extends StatelessWidget {
  final Student student;
  const ProfileScreen({super.key, required this.student});

  static const _subjects = [
    {'name': 'Mathematics', 'score': 88},
    {'name': 'Science', 'score': 81},
    {'name': 'English', 'score': 92},
    {'name': 'Social Studies', 'score': 76},
    {'name': 'Tamil', 'score': 85},
  ];

  static const _months = [
    {'m': 'February', 'v': '21/22 present'},
    {'m': 'March', 'v': '19/20 present'},
    {'m': 'April', 'v': '18/19 present'},
    {'m': 'May', 'v': '20/21 present'},
    {'m': 'June', 'v': '22/22 present'},
    {'m': 'July', 'v': '17/18 present'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(eyebrow: 'Record ${student.roll}', title: student.name),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(color: AppColors.paperRaised, border: Border.all(color: AppColors.line), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppColors.brass, Color(0xFF8B6430)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                      alignment: Alignment.center,
                      child: Text(student.initials, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Georgia')),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.name, style: const TextStyle(fontFamily: 'Georgia', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink)),
                          const SizedBox(height: 3),
                          Text('Roll ${student.roll}\nGuardian: Lakshmi Raghunathan', style: const TextStyle(fontSize: 11.5, color: AppColors.slate, height: 1.4)),
                          const SizedBox(height: 8),
                          Wrap(spacing: 6, children: [
                            _Tag(text: student.status, bg: AppColors.sageBg, fg: AppColors.sage),
                            const _Tag(text: 'House: Falcon', bg: AppColors.amberBg, fg: AppColors.amberText),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SectionPanel(
                title: 'Personal Details',
                child: const TwoColGrid(
                  children: [
                    _Field(label: 'Date of Birth', value: '14 Mar 2011'),
                    _Field(label: 'Blood Group', value: 'O+'),
                    _Field(label: 'Bus Route', value: 'Route 6'),
                    _Field(label: 'Fee Status', value: 'Paid', valueColor: AppColors.sage),
                  ],
                ),
              ),
              SectionPanel(
                title: 'Subject Performance',
                child: Column(children: _subjects.map((s) => _BarRow(subject: s['name'] as String, score: s['score'] as int)).toList()),
              ),
              SectionPanel(
                title: 'Attendance — Last 6 Months',
                child: TwoColGrid(
                  children: _months.map((m) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m['m']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink)),
                        Text(m['v']!, style: const TextStyle(fontSize: 11, color: AppColors.slate)),
                      ],
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final Color bg, fg;
  const _Tag({required this.text, required this.bg, required this.fg});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

// Two-column layout that sizes to its content instead of forcing a fixed
// aspect ratio — avoids the "RenderFlex overflowed by N pixels" error that
// GridView.count(childAspectRatio: ...) causes when text wraps or the
// device's font scale is larger than expected.
class TwoColGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  const TwoColGrid({super.key, required this.children, this.spacing = 14, this.runSpacing = 12});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - spacing) / 2;
        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((c) => SizedBox(width: itemWidth, child: c)).toList(),
        );
      },
    );
  }
}

class _Field extends StatelessWidget {
  final String label, value;
  final Color valueColor;
  const _Field({required this.label, required this.value, this.valueColor = AppColors.ink});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(fontSize: 9.5, color: AppColors.slate, letterSpacing: .4)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: valueColor)),
      ],
    );
  }
}

class _BarRow extends StatelessWidget {
  final String subject;
  final int score;
  const _BarRow({required this.subject, required this.score});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text(subject, style: const TextStyle(fontSize: 12, color: AppColors.ink))),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(value: score / 100, minHeight: 8, backgroundColor: AppColors.line, color: AppColors.brass),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 28, child: Text('$score', textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: AppColors.slate))),
        ],
      ),
    );
  }
}

// ───────────────────────── ATTENDANCE ─────────────────────────

class AttendanceScreen extends StatelessWidget {
  final Map<String, String> attendance;
  final void Function(String roll, String status) onSetStatus;
  const AttendanceScreen({super.key, required this.attendance, required this.onSetStatus});

  @override
  Widget build(BuildContext context) {
    final present = attendance.values.where((v) => v == 'Present').length;
    final absent = attendance.values.where((v) => v == 'Absent').length;
    final late = attendance.values.where((v) => v == 'Late').length;

    return Column(
      children: [
        const TopBar(eyebrow: 'Daily Register', title: 'Attendance', subtitle: '29 July 2026 · Grade 10-B'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  _SummaryChip(n: '$present', label: 'Present', color: AppColors.sage),
                  const SizedBox(width: 8),
                  _SummaryChip(n: '$absent', label: 'Absent', color: AppColors.rust),
                  const SizedBox(width: 8),
                  _SummaryChip(n: '$late', label: 'Late', color: AppColors.amberText),
                ],
              ),
              const SizedBox(height: 16),
              SectionPanel(
                title: 'Roster',
                child: Column(
                  children: kStudents.map((s) {
                    final status = attendance[s.roll] ?? 'Present';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [RollBadge(roll: s.roll), const SizedBox(width: 8), Text(s.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink))]),
                          const SizedBox(height: 6),
                          Row(
                            children: ['Present', 'Absent', 'Late'].map((opt) {
                              final active = status == opt;
                              final color = opt == 'Present' ? AppColors.sage : opt == 'Absent' ? AppColors.rust : AppColors.amberText;
                              final bg = opt == 'Present' ? AppColors.sageBg : opt == 'Absent' ? AppColors.rustBg : AppColors.amberBg;
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: OutlinedButton(
                                    onPressed: () => onSetStatus(s.roll, opt),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: active ? bg : AppColors.paperRaised,
                                      side: BorderSide(color: active ? color : AppColors.line, width: 1.4),
                                      foregroundColor: active ? color : AppColors.slate,
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    child: Text(opt, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.ink, foregroundColor: AppColors.paper, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  child: const Text('Save Register', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String n, label;
  final Color color;
  const _SummaryChip({required this.n, required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: AppColors.paperRaised, border: Border.all(color: AppColors.line), borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Text(n, style: TextStyle(fontFamily: 'Georgia', fontSize: 20, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 2),
            Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, color: AppColors.slate, letterSpacing: .4)),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── GRADES ─────────────────────────

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  static const _dist = [
    {'lbl': 'A', 'cnt': 18, 'h': 70.0, 'kind': 'a'},
    {'lbl': 'A-', 'cnt': 34, 'h': 100.0, 'kind': 'a'},
    {'lbl': 'B+', 'cnt': 41, 'h': 115.0, 'kind': 'b'},
    {'lbl': 'B', 'cnt': 29, 'h': 85.0, 'kind': 'b'},
    {'lbl': 'C', 'cnt': 17, 'h': 55.0, 'kind': 'f'},
    {'lbl': 'D', 'cnt': 9, 'h': 30.0, 'kind': 'f'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBar(eyebrow: 'Assessment', title: 'Grades & Reports', subtitle: 'Term II · Unit Test II'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SectionPanel(
                title: 'Grade Distribution',
                child: Column(
                  children: [
                    Row(children: const [
                      _LegendDot(color: AppColors.sage, label: 'A range'),
                      SizedBox(width: 12),
                      _LegendDot(color: AppColors.brass, label: 'B range'),
                      SizedBox(width: 12),
                      _LegendDot(color: AppColors.rust, label: 'C & below'),
                    ]),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: _dist.map((d) {
                          final color = d['kind'] == 'a' ? AppColors.sage : d['kind'] == 'f' ? AppColors.rust : AppColors.brass;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${d['cnt']}', style: const TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: AppColors.ink)),
                                  const SizedBox(height: 4),
                                  Container(height: d['h'] as double, decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))),
                                  const SizedBox(height: 4),
                                  Text(d['lbl'] as String, style: const TextStyle(fontSize: 10.5, color: AppColors.slate)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SectionPanel(
                title: 'Term Summary',
                child: const TwoColGrid(
                  children: [
                    _Field(label: 'Class Avg.', value: '78.4 / 100'),
                    _Field(label: 'Highest', value: '97 — D. Prakash'),
                    _Field(label: 'Pass Rate', value: '94%', valueColor: AppColors.sage),
                    _Field(label: 'At-Risk', value: '6 flagged', valueColor: AppColors.rust),
                  ],
                ),
              ),
              SectionPanel(
                title: 'Report Sheet',
                child: Column(
                  children: kStudents.map((s) {
                    final kind = s.grade.startsWith('A') ? 'A' : s.grade.startsWith('B') ? 'B' : 'C';
                    final color = kind == 'A' ? AppColors.sage : kind == 'B' ? AppColors.amberText : AppColors.rust;
                    final bg = kind == 'A' ? AppColors.sageBg : kind == 'B' ? AppColors.amberBg : AppColors.rustBg;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(s.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.ink)),
                                const SizedBox(height: 2),
                                RollBadge(roll: s.roll),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
                            child: Text(s.grade, style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 12.5, color: color)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 11, color: AppColors.slate)),
    ]);
  }
}