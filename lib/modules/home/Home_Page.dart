//import 'dart:html';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar2 = AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text("My App"),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notification_important)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ]);

    return Scaffold(
        appBar: appBar2,
        body: Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Image(
                          image: NetworkImage(
                              "https://lumiere-a.akamaihd.net/v1/images/hb_placeholder_desktop_7575eb06.jpeg?region=0%2C0%2C540%2C810"),
                          width: 200.0,
                          //  height: 200.0,
                          ///   fit: BoxFit.cover,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          color: Colors.black.withOpacity(.7),
                          width: 200.0,
                          // width: double.infinity,
                          child: Text(
                            'Iron Man',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
