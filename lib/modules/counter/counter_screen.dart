import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toto_app/modules/counter/cubit/cubit.dart';
import 'package:toto_app/modules/counter/cubit/state.dart';

//state less contain one class
//statefull contain two classes:
//1. first class provide widget
//2.second class provide state from this widgrt

// ignore: avoid_web_libraries_in_flutter
class CounterScreen extends StatelessWidget {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CounterCubit(),
        child: BlocConsumer<CounterCubit,CounterState>(builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text("Counter")),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                        // setState(() {
                        //   counter--;
                        // });
                      },
                      child: Text("Minus ")),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "${CounterCubit.get(context).counter}",
                      style: const TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                        // setState(() {
                        //   counter++;
                        // });
                      },
                      child: Text("Plus ")),
                ],
              ),
            ),
          );
        },
         listener: (context, state) {
// if (state is CounterMinusState) print("Minus State!!!!!${state.counter}!");
          // if (state is CounterPluseState) print("plus State!!!!!!!${state.counter}");
        }));
  }
}
