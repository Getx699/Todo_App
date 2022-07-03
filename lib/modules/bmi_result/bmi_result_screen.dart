// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BMIResult extends StatelessWidget {
  final int result;
  final bool isMal;
  final int age;

  BMIResult({required this.age, required this.result, required this.isMal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("BMI Result"),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.keyboard_arrow_left))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " Gender : ${isMal ? "Male" : "Female"}",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                " Result : $result",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                " Age : $age",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }
}
