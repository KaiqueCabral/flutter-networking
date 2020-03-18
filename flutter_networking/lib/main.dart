import 'package:flutter/material.dart';
import 'package:flutter_networking/home.dart';
import 'package:flutter_networking/views/fetch-categories.dart';
import 'package:flutter_networking/views/fetch-data.dart';
import 'package:flutter_networking/views/parse-photos.dart';

void main() => runApp(AppCookbookNetworking());

class AppCookbookNetworking extends StatefulWidget {
  AppCookbookNetworking({Key key}) : super(key: key);

  @override
  _AppCookbookNetworkingState createState() => _AppCookbookNetworkingState();
}

class _AppCookbookNetworkingState extends State<AppCookbookNetworking> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cookbook | Networking",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: "Networking",
      ),
      initialRoute: HomePage.routeName,
      routes: <String, WidgetBuilder>{
        FetchCategoriesPage.routeName: (BuildContext context) =>
            FetchCategoriesPage(),
        FetchDataPage.routeName: (BuildContext context) => FetchDataPage(),
        ParsePhotosPage.routeName: (BuildContext context) => ParsePhotosPage(),
      },
    );
  }
}
