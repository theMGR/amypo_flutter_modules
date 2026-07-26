import 'package:flutter_bloc/flutter_bloc.dart';

// Session 4 — the BLoC pattern: UI dispatches Events, the Bloc maps each
// Event to zero or more States, and the UI rebuilds in response to State.
// This keeps business logic (this file) completely separate from
// presentation (the screen widget).

sealed class CounterEvent {}

class CounterIncremented extends CounterEvent {}

class CounterDecremented extends CounterEvent {}

class CounterReset extends CounterEvent {}

class CounterState {
  final int value;
  const CounterState(this.value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    on<CounterIncremented>((event, emit) => emit(CounterState(state.value + 1)));
    on<CounterDecremented>((event, emit) => emit(CounterState(state.value - 1)));
    on<CounterReset>((event, emit) => emit(const CounterState(0)));
  }
}
