// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:toto_app/modules/web_view/web_view.dart';
import 'package:toto_app/shared/shared_cubit/cubit.dart';

import '../../modules/bmi_result/bmi_result_screen.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        double radius = 40.0,
        required function,
        required String text,
        bool isUpperCase = true}) =>
    Container(
      height: 40.0,
      width: width,
      child: MaterialButton(
          onLongPress: () {},
          onPressed: () {
            function();
          },
          child: Text(
            isUpperCase ? text.toUpperCase() : text.toLowerCase(),
            style: TextStyle(color: Colors.white),
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(radius),
        color: background,
      ),
    );

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit, //Add question mark
  Function? onChange, //Add question mark
  Function? onTap,
  required Function? validate,
  required var label,
  required IconData prefix,
}) =>
    TextFormField(
      onTap: onTap != null ? onTap() : null,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit != null ? onSubmit() : null, //do null checking
      onChanged: onChange != null ? onChange() : null, //do null checking
      validator: (value) {
        return validate!(value);
      },
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          border: OutlineInputBorder()),
    );
Widget buildTaskItiem(Map model, context) {
  return Dismissible(
    key: Key(model["id"].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text("${model["time"]}"),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model["title"]}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                Text(
                  "${model["date"]}",
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).UpdateData(status: "done", id: model["id"]);
            },
            icon: Icon(Icons.check_box),
            color: Colors.black54,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .UpdateData(status: "archive", id: model["id"]);
            },
            icon: Icon(Icons.archive),
            color: Colors.grey,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).UpdateData(status: "new", id: model["id"]);
            },
            icon: Icon(Icons.add_circle_outlined),
            color: Colors.black54,
          ),
        ],
      ),
    ),
    onDismissed: (direcion) {
      AppCubit.get(context).deleteData(id: model["id"]);
    },
  );
}

Widget MyDividor() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.black,
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, webViewScreen(url:article["url"] ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(
                        '${article['urlToImage']}',
                      ),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.start,

                  // ignore: prefer_const_literals_to_create_immutables

                  children: [
                    Text(
                      "${article['title']}",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articleBulder(list, context,{isSearch=false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => MyDividor(),
          itemCount: list.length),
      fallback: (context) => isSearch? Container(): Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
