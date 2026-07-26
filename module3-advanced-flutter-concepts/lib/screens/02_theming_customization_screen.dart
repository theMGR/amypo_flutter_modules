import 'package:flutter/material.dart';

// Session 2 — Theming and customization: ThemeData, MaterialApp.theme /
// darkTheme / themeMode, Theme.of(context), ColorScheme.fromSeed.
//
// The authoritative ThemeMode state lives in main.dart's Module3App (the
// app root) so that changing it rebuilds the WHOLE app. This screen is a
// StatefulWidget that mirrors that value in local state: it updates its
// own state immediately for instant visual feedback AND calls the
// callback to update the app root. (A screen reached via Navigator.push
// does not automatically get rebuilt just because an ancestor above the
// Navigator changed state — mirroring locally avoids relying on that.)

class ThemingCustomizationScreen extends StatefulWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onModeChanged;

  const ThemingCustomizationScreen({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  State<ThemingCustomizationScreen> createState() => _ThemingCustomizationScreenState();
}

class _ThemingCustomizationScreenState extends State<ThemingCustomizationScreen> {
  late ThemeMode _mode = widget.currentMode;

  void _select(ThemeMode mode) {
    setState(() => _mode = mode);
    widget.onModeChanged(mode);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('02 - Theming & Customization')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current ThemeMode: ${_mode.name}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.light, label: Text('Light'), icon: Icon(Icons.light_mode)),
                ButtonSegment(value: ThemeMode.dark, label: Text('Dark'), icon: Icon(Icons.dark_mode)),
                ButtonSegment(value: ThemeMode.system, label: Text('System'), icon: Icon(Icons.settings_suggest)),
              ],
              selected: {_mode},
              onSelectionChanged: (selection) => _select(selection.first),
            ),
            const SizedBox(height: 24),
            Text('Reading values from Theme.of(context):', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'This box uses colorScheme.primaryContainer, so it adapts '
                'automatically when the theme mode changes.',
                style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
              ),
            ),
            const SizedBox(height: 16),
            Text('This text uses textTheme.headlineSmall', style: theme.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
