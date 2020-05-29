import 'package:flutter_infinite_list/features/catalog_page/domain/entities/catalog_page_post.dart';

class PostModel extends Post {
  PostModel({
    int id,
    String title,
    String body,
    String posterUrl,
}): super(
    id: id,
    title: title,
    body: body,
    posterUrl: posterUrl,
    count: 1
  );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['overview'],
      posterUrl: _posterBodyUrl + json['poster_path'],
    );

  }
}