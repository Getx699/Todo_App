// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toto_app/layout/news_app/cubit/state.dart';
import 'package:toto_app/modules/business/business_screen.dart';
import 'package:toto_app/modules/science/science_screen.dart';
import 'package:toto_app/modules/settings_screen/settings_screen.dart';
import 'package:toto_app/modules/sports/sport_screen.dart';
import 'package:toto_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index) {
    if (index == 1) getSports();
    if (index == 2) getScience();
    currentIndex = index;
    emit(NewBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'a0dbe62c8d16440585c20668dcca7087',
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'a0dbe62c8d16440585c20668dcca7087',
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsSportsSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsScienceLoadingState());

    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'a0dbe62c8d16440585c20668dcca7087',
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsScienceSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsSearchLoadingState());
    search = [];
    DioHelper.getData(url: 'v2/everything', query: {
     
      'q': '$value',
      'apiKey': 'a0dbe62c8d16440585c20668dcca7087',
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
