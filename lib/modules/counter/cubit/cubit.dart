import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toto_app/modules/counter/cubit/state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitialState());

  // to use this cubit in many places
  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1;

  void plus() {
    counter++;
    emit(CounterPluseState(counter));          //change state
  }

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }
}
