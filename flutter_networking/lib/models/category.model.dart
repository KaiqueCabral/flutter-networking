class CategoryModel {
  final int id;
  final String title;
  final Object products;

  CategoryModel({this.id, this.title, this.products});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      products: json['products'],
    );
  }
}
