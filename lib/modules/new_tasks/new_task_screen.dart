import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toto_app/shared/shared_cubit/cubit.dart';
import 'package:toto_app/shared/components/components.dart';
import 'package:toto_app/shared/shared_cubit/state.dart';

// ignore: use_key_in_widget_constructors
class NewsTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newtasks;
          return ConditionalBuilder(
            condition: tasks.isNotEmpty,
            builder: (context) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return buildTaskItiem(tasks[index], context);
                  },
                  separatorBuilder: (context, index) => MyDividor(),
                  itemCount: tasks.length);
            },
            fallback: (context) { 
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu),
                    Text("No Tasks,Please Add Tasks")
                  ],
                ),
              );
            },
          );
        });
  }
}
