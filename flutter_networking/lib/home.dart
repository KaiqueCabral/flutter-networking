import 'package:flutter/material.dart';
import 'package:flutter_networking/views/fetch-data.dart';
import 'package:flutter_networking/views/parse-photos.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/";
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Use the menu to access the pages."),
      ),
      drawer: getNavDrawer(context),
    );
  }
}

Drawer getNavDrawer(BuildContext context) {
  ListTile getNavItem(IconData icon, String title, String routeName) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.lightBlueAccent,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(routeName);
      },
    );
  }

  var navItems = [
    DrawerHeader(
      curve: Curves.easeInOut,
      duration: Duration(seconds: 1),
      padding: EdgeInsets.zero,
      child: Container(
        color: Colors.blueAccent[200],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text(
            "Olá, Kaique!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    ),
    getNavItem(Icons.data_usage, "Fetch Data", FetchDataPage.routeName),
    getNavItem(Icons.photo_library, "Parse Photos", ParsePhotosPage.routeName),
  ];

  ListView listView = ListView(
    padding: EdgeInsets.zero,
    children: navItems,
  );

  return Drawer(
    child: listView,
    elevation: 0,
  );
}
