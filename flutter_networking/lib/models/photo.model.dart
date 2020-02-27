class PhotoModel {
  final int id;
  final String title;
  final String thumbnailUrl;

  PhotoModel({this.id, this.title, this.thumbnailUrl});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
