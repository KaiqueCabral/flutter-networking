import 'package:flutter/material.dart';
import 'package:flutter_networking/models/post.model.dart';
import 'package:flutter_networking/repositories/post.repository.dart';

class FetchDataPage extends StatefulWidget {
  static const String routeName = "/fetch-data";

  FetchDataPage({Key key}) : super(key: key);

  @override
  _FetchDataPageState createState() => _FetchDataPageState();
}

class _FetchDataPageState extends State<FetchDataPage> {
  int _postId = 1;
  Future<PostModel> post;
  PostRepository _repository = new PostRepository();

  @override
  void initState() {
    super.initState();
    post = _repository.fetchPost(_postId);
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
            post = _repository.fetchPost(_postId);
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
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: FutureBuilder(
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
                    default:
                      if (snapshot.hasError) {
                        return _container(
                          Center(
                            child: Text(
                              '${snapshot.error}',
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
                                  Text("User ID: ${snapshot.data.userId}"),
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
