import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_networking/models/photo.model.dart';

class PhotoRepository {
  Client http = new Client();
  Future<List<PhotoModel>> fetchPhotos() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/photos');

    return compute(parsePhotos, response.body);
  }

  List<PhotoModel> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<PhotoModel>((json) => PhotoModel.fromJson(json)).toList();
  }
}
