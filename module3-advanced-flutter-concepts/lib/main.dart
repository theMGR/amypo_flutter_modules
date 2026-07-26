import 'package:flutter/material.dart';

import 'screens/01_navigation_routing_screen.dart';
import 'screens/02_theming_customization_screen.dart';
import 'screens/03_animations_transitions_screen.dart';
import 'screens/04_bloc_state_management_screen.dart';
import 'screens/05_platform_specific_features_screen.dart';

void main() {
  runApp(const Module3App());
}

class Module3App extends StatefulWidget {
  const Module3App({super.key});

  @override
  State<Module3App> createState() => _Module3AppState();
}

class _Module3AppState extends State<Module3App> {
  // Session 2: theme state lives at the app root so changing it rebuilds
  // every screen in the app, not just one widget.
  ThemeMode _themeMode = ThemeMode.system;

  void _setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Module 3 - Advanced Flutter Concepts',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      darkTheme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark)),
      themeMode: _themeMode,
      home: HomeMenuScreen(themeMode: _themeMode, onThemeModeChanged: _setThemeMode),
      // Session 1: named routes registered via onGenerateRoute so we can
      // decode typed arguments before building the destination screen.
      onGenerateRoute: (settings) {
        if (settings.name == ProfileScreen.routeName) {
          final args = settings.arguments as ProfileArgs;
          return MaterialPageRoute<String>(builder: (_) => ProfileScreen(args: args));
        }
        return null;
      },
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
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const HomeMenuScreen({super.key, required this.themeMode, required this.onThemeModeChanged});

  List<_DemoEntry> _demos() => [
        _DemoEntry(
          '01 - Navigation & Routing',
          'Navigator, Route, named routes, arguments, result on pop',
          (_) => const NavigationRoutingScreen(),
        ),
        _DemoEntry(
          '02 - Theming & Customization',
          'ThemeData, light/dark ThemeMode, ColorScheme.fromSeed',
          (_) => ThemingCustomizationScreen(currentMode: themeMode, onModeChanged: onThemeModeChanged),
        ),
        _DemoEntry(
          '03 - Animations & Transitions',
          'AnimatedContainer, FadeTransition, Hero, PageRouteBuilder',
          (_) => const AnimationsTransitionsScreen(),
        ),
        _DemoEntry(
          '04 - BLoC State Management',
          'Bloc<Event, State>, BlocProvider, BlocBuilder',
          (_) => const BlocStateManagementScreen(),
        ),
        _DemoEntry(
          '05 - Platform-Specific Features',
          'battery_plus, device_info_plus, Clipboard, HapticFeedback',
          (_) => const PlatformSpecificFeaturesScreen(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final demos = _demos();
    return Scaffold(
      appBar: AppBar(title: const Text('Module 3 - Advanced Flutter Concepts')),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: demos.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final demo = demos[index];
          return ListTile(
            title: Text(demo.title),
            subtitle: Text(demo.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: demo.builder)),
          );
        },
      ),
    );
  }
}
