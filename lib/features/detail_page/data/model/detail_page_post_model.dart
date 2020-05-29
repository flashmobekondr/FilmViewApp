import 'package:flutter_infinite_list/features/detail_page/domain/entities/detail_page_post.dart';

class DetailPostModel extends DetailPost {
  DetailPostModel({
    int id,
    String title,
    String posterUrl,
    String body,
  }): super(
    id: id,
    title: title,
    posterUrl: posterUrl,
    body: body,
  );

  factory DetailPostModel.fromJson(Map<String, dynamic> json) {
    final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
    return DetailPostModel(
        id: json['id'],
        title: json['title'],
        posterUrl: _posterBodyUrl+ json['poster_path'],
        body: json['overview']
    );
  }
}