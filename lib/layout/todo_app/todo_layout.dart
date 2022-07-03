// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toto_app/modules/new_tasks/new_task_screen.dart';
import 'package:toto_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:toto_app/modules/archive_tasks/archive_tasks_screen.dart';
import 'package:toto_app/shared/components/components.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:toto_app/shared/shared_cubit/cubit.dart';
import 'package:toto_app/shared/shared_cubit/state.dart';

class HomeLayout extends StatelessWidget {
  // Future<String> getName() async {
  //   return "Ahmed Mohamed";
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   creatDatabase();
  // }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AppCubit()..creatDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
            timeControler.clear();
            titleControler.clear();
            dateControler.clear();
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currrentindex]),
            ),
            floatingActionButton: FloatingActionButton(
              //*********************** */
              onPressed: () {
                if (cubit.isButtonsheetShown) {
                  // bool isButtonsheetShown = false;
                  // IconData fbButton = Icons.edit;
                  if (formKey.currentState!.validate()) {
                    cubit.insertIntoDatabase(
                        title: titleControler.text,
                        time: timeControler.text,
                        date: dateControler.text);
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                          (context) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  color: Colors.white,
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        defaultFormFeild(
                                            controller: titleControler,
                                            type: TextInputType.text,
                                            validate: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Title must be not empty";
                                              }
                                              return null;
                                            },
                                            label: " Task Ttle",
                                            prefix: Icons.title),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                            controller: timeControler,
                                            keyboardType:
                                                TextInputType.datetime,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Time must be not empty";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                prefixIcon: Icon(
                                                  Icons.watch_later_outlined,
                                                ),
                                                labelText: "Time Title"),
                                            // enabled: false,
                                            onTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now())
                                                  .then((value) {
                                                timeControler.text = value!
                                                    .format(context)
                                                    .toString();
                                              });
                                            }),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                            controller: dateControler,
                                            keyboardType:
                                                TextInputType.datetime,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Date must be not empty";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                prefixIcon: Icon(
                                                  Icons.calendar_today,
                                                ),
                                                labelText: "Date Title"),
                                            onTap: () {
                                              showDatePicker(
                                                      initialEntryMode:
                                                          DatePickerEntryMode
                                                              .calendarOnly,
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime.parse(
                                                          '2022-06-08'))
                                                  .then((value) {
                                                dateControler.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!.toUtc());
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          elevation: 20.0)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fbButton),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currrentindex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: "Done"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: "Archive"),
                ]),
            body: ConditionalBuilder(
              condition: state is! AppGetDataBaseLoadingState,
              builder: (context) => cubit.screens[cubit.currrentindex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
