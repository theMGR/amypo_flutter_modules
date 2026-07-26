import 'package:flutter/material.dart';

// Session 5 — Buttons (expanded widget set): ElevatedButton, TextButton,
// OutlinedButton, IconButton, FloatingActionButton, disabled state.

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  int _counter = 0;
  bool _busy = false;

  void _increment() => setState(() => _counter++);

  Future<void> _simulateWork() async {
    setState(() => _busy = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('05 - Buttons')),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment counter',
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Counter: $_counter (wired to the FloatingActionButton via setState)'),
            const SizedBox(height: 16),

            const Text('Button variants:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(onPressed: _increment, child: const Text('ElevatedButton')),
                TextButton(onPressed: _increment, child: const Text('TextButton')),
                OutlinedButton(onPressed: _increment, child: const Text('OutlinedButton')),
                IconButton(onPressed: _increment, icon: const Icon(Icons.thumb_up), tooltip: 'IconButton'),
                ElevatedButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.download),
                  label: const Text('icon + label'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Disabled state (onPressed: null):', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const ElevatedButton(onPressed: null, child: Text('Disabled')),
            const SizedBox(height: 24),

            const Text('Async work with a loading indicator:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _busy ? null : _simulateWork,
              child: _busy
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Simulate work'),
            ),
          ],
        ),
      ),
    );
  }
}
