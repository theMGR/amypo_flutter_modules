import 'package:flutter/material.dart';

// Session 2 — Stateless vs Stateful widgets.
//
// A StatelessWidget's build() output depends only on the configuration
// passed into it (its constructor args) — it never changes itself.
// A StatefulWidget holds mutable State that can call setState() to
// trigger a rebuild with new values.

class ClockCard extends StatelessWidget {
  final String label; // fixed at construction time — this widget never changes itself
  const ClockCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Stateless: $label', style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class TapCounterCard extends StatefulWidget {
  const TapCounterCard({super.key});

  @override
  State<TapCounterCard> createState() => _TapCounterCardState();
}

class _TapCounterCardState extends State<TapCounterCard> {
  int _taps = 0; // mutable state, survives across rebuilds of this widget

  void _increment() {
    setState(() => _taps++); // tells Flutter to re-run build() below
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stateful: tapped $_taps times'),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _increment, child: const Text('Tap me')),
          ],
        ),
      ),
    );
  }
}

class StatelessStatefulScreen extends StatelessWidget {
  const StatelessStatefulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('02 - Stateless vs Stateful')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ClockCard(label: 'this text never changes on its own'),
            SizedBox(height: 12),
            TapCounterCard(),
          ],
        ),
      ),
    );
  }
}
