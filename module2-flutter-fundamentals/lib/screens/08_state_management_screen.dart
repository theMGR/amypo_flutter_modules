import 'package:flutter/material.dart';

// Session 8 — State management basics: setState recap + "lifting state up"
// (a shared value lives in the parent; children receive it plus a callback
// to change it, rather than each child holding its own copy).
//
// Note for learners: for apps bigger than this, you'd reach for a state
// management package (Provider, Riverpod, Bloc) instead of passing
// callbacks by hand — that's covered in a later module.

class StateManagementScreen extends StatefulWidget {
  const StateManagementScreen({super.key});

  @override
  State<StateManagementScreen> createState() => _StateManagementScreenState();
}

class _StateManagementScreenState extends State<StateManagementScreen> {
  int _sharedCounter = 0; // the single source of truth, owned by the parent

  void _increment() => setState(() => _sharedCounter++);
  void _decrement() => setState(() => _sharedCounter--);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('08 - State Management')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Two independent child widgets below both read and update the '
              'SAME counter, which lives in this parent screen\'s State.',
            ),
            const SizedBox(height: 16),
            CounterDisplay(count: _sharedCounter),
            const SizedBox(height: 16),
            CounterControls(onIncrement: _increment, onDecrement: _decrement),
          ],
        ),
      ),
    );
  }
}

// A read-only child: it only receives the current value, never mutates it.
class CounterDisplay extends StatelessWidget {
  final int count;
  const CounterDisplay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Shared count: $count', style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}

// A control child: it never stores the count itself — it just calls back
// up to the parent, which owns the state and decides how it changes.
class CounterControls extends StatelessWidget {
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  const CounterControls({super.key, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: onDecrement, child: const Text('-')),
        const SizedBox(width: 12),
        ElevatedButton(onPressed: onIncrement, child: const Text('+')),
      ],
    );
  }
}
