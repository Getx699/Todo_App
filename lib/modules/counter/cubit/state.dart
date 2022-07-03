abstract class CounterState {}

class CounterInitialState extends CounterState {}

class CounterPluseState extends CounterState {
  // ignore: prefer_typing_uninitialized_variables
  final counter;

  CounterPluseState(this.counter);
}

class CounterMinusState extends CounterState {
  final counter;

  CounterMinusState(this.counter);
}
