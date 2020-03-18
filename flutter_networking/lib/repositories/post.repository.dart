import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:flutter_networking/models/post.model.dart';

class PostRepository {
  Client http = new Client();

  Future<PostModel> fetchPost(int _id) async {
    final response =
        await http.get("http://jsonplaceholder.typicode.com/posts/$_id");
    //await new Future.delayed(const Duration(seconds: 5)); //To show Circular

    if (response.statusCode == 200) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load post.");
    }
  }
}
