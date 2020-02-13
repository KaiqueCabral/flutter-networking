import 'package:flutter/material.dart';
import 'package:flutter_networking/home.dart';
import 'package:flutter_networking/pages/fetch-data.dart';
import 'package:flutter_networking/pages/parse-photos.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fetch from URL",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: "Networking",
      ),
      routes: <String, WidgetBuilder>{
        FetchDataPage.routeName: (BuildContext context) => FetchDataPage(),
        ParsePhotosPage.routeName: (BuildContext context) => ParsePhotosPage(),
      },
    );
  }
}
