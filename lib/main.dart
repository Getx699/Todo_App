
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toto_app/layout/news_app/cubit/cubit.dart';
import 'package:toto_app/layout/news_app/news_layout.dart';

import 'package:toto_app/modules/counter/counter_Screen.dart';
import 'package:toto_app/modules/login/Login_screen.dart';
//ignore_for_file: prefer_const_constructors
import 'package:toto_app/layout/todo_app/todo_layout.dart';
import 'package:toto_app/shared/bloc_observer.dart';
import 'package:toto_app/shared/network/local/cach_helper.dart';
import 'package:toto_app/shared/network/remote/dio_helper.dart';
import 'package:toto_app/shared/shared_cubit/cubit.dart';
import 'package:toto_app/shared/shared_cubit/state.dart';
import 'modules/home/Home_Page.dart';
import 'modules/user/User_Screen.dart';
import 'modules/user/User_Screen.dart';
import 'modules/login/Login_screen.dart';
import 'modules/messenger/Massenger_Screen.dart';
import 'modules/bmi/bmi_screen.dart';
import 'modules/bmi_result/bmi_result_screen.dart';

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init;
      await CasheHelper.init;
      bool? isDark = CasheHelper.getBool(key: "isDark");
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience(),
          ),
           BlocProvider(
            create: (context) => AppCubit()..changeAppMode(fromShared: isDark)),
        ],
       
            child: BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return MaterialApp(
                    
                    theme: ThemeData(
                        primarySwatch: Colors.teal,
                        scaffoldBackgroundColor: Colors.white,
                        appBarTheme: AppBarTheme(
                            titleSpacing: 20.0,
                            iconTheme: IconThemeData(color: Colors.black),
                            titleTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            backgroundColor: Colors.white,
                            systemOverlayStyle: SystemUiOverlayStyle(
                                statusBarColor: Colors.white,
                                statusBarIconBrightness: Brightness.dark),
                            elevation: 0.0),
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                            type: BottomNavigationBarType.fixed,
                            elevation: 25.0,
                            selectedItemColor: Colors.teal,
                            backgroundColor: Colors.white),
                        textTheme: TextTheme(
                            bodyText1: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black))),
                    debugShowCheckedModeBanner: false,
                    darkTheme: ThemeData(
                        primarySwatch: Colors.teal,
                        appBarTheme: AppBarTheme(
                            titleSpacing: 20.0,
                            iconTheme: IconThemeData(color: Colors.white),
                            titleTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            backgroundColor: HexColor("333739"),
                            systemOverlayStyle: SystemUiOverlayStyle(
                                statusBarColor: HexColor("333739"),
                                statusBarIconBrightness: Brightness.light),
                            elevation: 0.0),
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                            backgroundColor: HexColor("333739"),
                            type: BottomNavigationBarType.fixed,
                            elevation: 25.0,
                            selectedItemColor: Colors.teal),
                        unselectedWidgetColor: Colors.grey,
                        scaffoldBackgroundColor: HexColor("333739"),
                        textTheme: TextTheme(
                            bodyText1: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white))),
                    themeMode: AppCubit.get(context).isDark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    home: Directionality(
                        textDirection: TextDirection.rtl, child: NewsLayout()),
                  );
                }));
  }
}


//NewsCubit()..getBusiness()..getSports()..getScience()