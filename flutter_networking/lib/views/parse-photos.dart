import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_networking/models/photo.model.dart';
import 'package:flutter_networking/repositories/photos.repository.dart';

class ParsePhotosPage extends StatelessWidget {
  static const String routeName = "/parse-photos";
  ParsePhotosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PhotoRepository _repository = new PhotoRepository();

    return Scaffold(
      appBar: AppBar(
        title: Text("Parse Photos"),
      ),
      body: FutureBuilder<List<PhotoModel>>(
        future: _repository.fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<PhotoModel> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
