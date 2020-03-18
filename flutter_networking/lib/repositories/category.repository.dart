import 'dart:convert';

import 'package:flutter_networking/models/category.model.dart';
import 'package:http/http.dart' show Client;

class CategoryRepository {
  Client http = new Client();

  Future<CategoryModel> fetchCategory(int _id) async {
    final response = await http.get("http://10.0.2.2/api/v1/categories/$_id");

    switch (response.statusCode) {
      case 200:
        return CategoryModel.fromJson(json.decode(response.body));
      default:
        throw Exception("Failed to load post.");
    }
  }
}
