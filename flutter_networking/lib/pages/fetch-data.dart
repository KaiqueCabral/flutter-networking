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
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetching Data from URL"),
      ),
      body: Container(
        color: Colors.blue[100],
        constraints: BoxConstraints.expand(),
        child: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("ID: ${snapshot.data.id}"),
                        Text("User ID: ${snapshot.data.userId}"),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20,
                      ),
                      child: Text(
                        snapshot.data.title,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
