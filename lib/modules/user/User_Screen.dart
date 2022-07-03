// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import 'package:toto_app/models/user/user_model.dart';
class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: "ahmed", phone: "01092989374"),
    UserModel(id: 2, name: "ali", phone: "0111112223"),
    UserModel(id: 3, name: "mona", phone: "23292989374"),
    UserModel(id: 4, name: "hend", phone: "0123292989374"),
    UserModel(id: 5, name: "hossam", phone: "12392989374"),
    UserModel(id: 6, name: "mohamed", phone: "012392989374"),
    UserModel(id: 7, name: "gamal", phone: "04392989374"),
    UserModel(id: 8, name: "zain", phone: "01142989374"),
  ];

  // UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User"),
        ),
        body: ListView.separated(
            itemBuilder: (context, i) => BuildItem(users[i]),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[250],
                ),
            itemCount: users.length));
  }

  Widget BuildItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${user.id}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${user.name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                Text(
                  "${user.phone}",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      );
}
