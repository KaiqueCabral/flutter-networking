import 'package:flutter/material.dart';
import 'package:flutter_networking/models/category.model.dart';
import 'package:flutter_networking/repositories/category.repository.dart';

class FetchCategoriesPage extends StatefulWidget {
  static const String routeName = "/fetch-categories";

  FetchCategoriesPage({Key key}) : super(key: key);

  @override
  _FetchCategoriesPageState createState() => _FetchCategoriesPageState();
}

class _FetchCategoriesPageState extends State<FetchCategoriesPage> {
  int _id = 1;
  Future<CategoryModel> category;
  CategoryRepository _repository = new CategoryRepository();

  @override
  void initState() {
    super.initState();
    category = _repository.fetchCategory(_id);
  }

  _navButton(IconData _icon, int incrementDecrement) => RaisedButton(
        color: Colors.blue[900],
        child: Icon(
          _icon,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            _id = _id + incrementDecrement;
            category = _repository.fetchCategory(_id);
          });
        },
      );

  _container(Widget _widget) => Container(
        color: Colors.white38,
        padding: EdgeInsets.all(25),
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: 250,
        ),
        child: _widget,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetching Categories from URL"),
      ),
      body: Container(
        color: Colors.blue[100],
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _navButton(Icons.navigate_before, -1),
                    _navButton(Icons.navigate_next, 1),
                  ],
                ),
              ),
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: FutureBuilder(
                future: category,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return _container(
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return _container(
                          Center(
                            child: Text(
                              '${snapshot.error} Failed to load the category: $_id',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      } else {
                        return _container(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("ID: ${snapshot.data.id}"),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: Text(
                                  snapshot.data.title,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
