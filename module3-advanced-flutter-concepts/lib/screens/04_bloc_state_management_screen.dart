import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc.dart';

// Session 4 — Advanced state management: the BLoC pattern.
// BlocProvider creates and disposes the Bloc for the widget subtree below
// it. BlocBuilder rebuilds only when the Bloc emits a new State, and the
// UI never mutates state directly — it only dispatches Events via add().

class BlocStateManagementScreen extends StatelessWidget {
  const BlocStateManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      // `builder` hands us a BuildContext that sits BELOW the BlocProvider,
      // so context.read<CounterBloc>() inside it can find the bloc. The
      // outer `context` parameter of this build() method sits ABOVE the
      // BlocProvider and cannot see it.
      child: const _BlocScaffold(),
    );
  }
}

class _BlocScaffold extends StatelessWidget {
  const _BlocScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('04 - BLoC State Management')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'UI dispatches events (add) -> CounterBloc maps events to '
              'new states (on<Event>) -> BlocBuilder rebuilds on each state.',
            ),
            const SizedBox(height: 16),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) => Text(
                'Count: ${state.value}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterDecremented()),
                  child: const Text('-'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterIncremented()),
                  child: const Text('+'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterReset()),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
