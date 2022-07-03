// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toto_app/shared/network/local/cach_helper.dart';
import 'package:toto_app/shared/shared_cubit/state.dart';

import '../../modules/archive_tasks/archive_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_task_screen.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currrentindex = 0;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  List<Widget> screens = [
    NewsTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];

  List<String> title = ["New Task", "Done Task", "Archive Task"];
  bool isButtonsheetShown = false;
  IconData fbButton = Icons.edit;
  void changeIndex(int index) {
    currrentindex = index;
    emit(AppChangeBottomNabBarState());
  }

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isButtonsheetShown = isShow;
    fbButton = icon;
    emit(AppChangeBottomsheetState());
  }

  Database? database;

  void creatDatabase() {
    openDatabase('todoo.db', version: 1, onCreate: (database, verion) {
      print("DataBase created!!!");

      database
          .execute(
              ' CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT) ') //creat table(id int,title  String, date String ,time string ,status strin  )
          .then((value) {
        // ignore: avoid_print
        print("Table Created");
      }).catchError((error) {
        print("Error when creating table ${error.toString()}");
      });
    }, onOpen: (database) {
      getDateFromDatabase(database);
      print("DataBase Opened!!!!###");
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertIntoDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) async {
      txn
          .rawInsert(
              ' INSERT INTO tasks(title, date, time, status) VALUES(" $title "," $date  "," $time"," new ")')
          .then((value) {
        print(" $value Insert syccessefuly!!!!!");
        emit(AppInsertDataBaseState());
        getDateFromDatabase(database);
      }).catchError((error) {
        print("Error When Inserting new record ${error.toString()}");
      });
      return null;
    });
  }

  void getDateFromDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    emit(AppGetDataBaseLoadingState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      // newtasks = value;
      print(value);
      value.forEach((element) {
        if (element["status"] == "new") {
          newtasks.add(element);
        } else if (element["status"] == "done") {
          donetasks.add(element);
        } else {
          archivetasks.add(element);
        }
      });

      emit(AppGetDataBaseState());
    });
  }

  void UpdateData({required String status, required int id}) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDateFromDatabase(database);
      emit(AppUpdatetDataBaseState());
    });
  }

  void deleteData({required int id}) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDateFromDatabase(database);
      emit(AppDelettDataBaseState());
    });
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
      return ;
    }
    
      isDark = !isDark;

      CasheHelper.putBool(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    
  }
}
