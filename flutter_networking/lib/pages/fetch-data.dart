import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_networking/models/post.dart';

Future<Post> fetchPost(int _id) async {
  final response =
      await http.get("https://jsonplaceholder.typicode.com/posts/$_id");

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load post.");
  }
}

class FetchDataPage extends StatefulWidget {
  static const String routeName = "/fetch-data";

  FetchDataPage({Key key}) : super(key: key);

  @override
  _FetchDataPageState createState() => _FetchDataPageState();
}

class _FetchDataPageState extends State<FetchDataPage> {
  int _postId = 1;
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost(_postId);
  }

  _navButton(IconData _icon, int incrementDecrement) => RaisedButton(
        color: Colors.blue[900],
        child: Icon(
          _icon,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            _postId = _postId + incrementDecrement;
            post = fetchPost(_postId);
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
        title: Text("Fetching Data from URL"),
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
              height: 150,
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return _container(
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return _container(
                          Text(
                            '${snapshot.error}',
                            style: TextStyle(color: Colors.red),
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
                                  Text("User ID: ${snapshot.data.userId}"),
                                ],
                              ),
                              Padding(
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

                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
