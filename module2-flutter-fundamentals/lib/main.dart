import 'package:flutter/material.dart';

import 'screens/02_stateless_stateful_screen.dart';
import 'screens/03_layouts_screen.dart';
import 'screens/04_text_image_icon_screen.dart';
import 'screens/05_buttons_screen.dart';
import 'screens/06_inputs_lists_screen.dart';
import 'screens/07_navigation_structure_screen.dart';
import 'screens/08_state_management_screen.dart';
import 'screens/09_more_common_widgets_screen.dart';

void main() {
  runApp(const Module2App());
}

// Session 1: MaterialApp is the root widget that sets up theming and the
// widget tree. Scaffold gives each screen the standard app structure
// (AppBar + body + optional drawer/FAB/bottom nav).
class Module2App extends StatelessWidget {
  const Module2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Module 2 - Flutter Fundamentals',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: const HomeMenuScreen(),
    );
  }
}

class _DemoEntry {
  final String title;
  final String subtitle;
  final WidgetBuilder builder;
  const _DemoEntry(this.title, this.subtitle, this.builder);
}

class HomeMenuScreen extends StatelessWidget {
  const HomeMenuScreen({super.key});

  static final List<_DemoEntry> _demos = [
    _DemoEntry(
      '02 - Stateless vs Stateful',
      'build(), setState(), widget lifecycle',
      (_) => const StatelessStatefulScreen(),
    ),
    _DemoEntry(
      '03 - Layout techniques',
      'Row, Column, Stack, Container, Expanded, Wrap',
      (_) => const LayoutsScreen(),
    ),
    _DemoEntry(
      '04 - Text, Image, Icon',
      'TextStyle, Image.network, Icon, CircleAvatar',
      (_) => const TextImageIconScreen(),
    ),
    _DemoEntry(
      '05 - Buttons',
      'ElevatedButton, TextButton, OutlinedButton, IconButton, FAB',
      (_) => const ButtonsScreen(),
    ),
    _DemoEntry(
      '06 - Inputs & Lists',
      'TextField, Checkbox, Switch, Radio, Slider, ListView, GridView',
      (_) => const InputsListsScreen(),
    ),
    _DemoEntry(
      '07 - Navigation & Structure',
      'AppBar, Drawer, BottomNavigationBar, SnackBar, AlertDialog, Navigator',
      (_) => const NavigationStructureScreen(),
    ),
    _DemoEntry(
      '08 - State Management',
      'Lifting state up, shared counter via callbacks',
      (_) => const StateManagementScreen(),
    ),
    _DemoEntry(
      '09 - More Common Widgets',
      'Form, Dropdown, Tabs, ExpansionTile, Tooltip, DataTable, PageView, BottomSheet',
      (_) => const MoreCommonWidgetsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Module 2 - Flutter Fundamentals')),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _demos.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final demo = _demos[index];
          return ListTile(
            title: Text(demo.title),
            subtitle: Text(demo.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: demo.builder),
            ),
          );
        },
      ),
    );
  }
}
