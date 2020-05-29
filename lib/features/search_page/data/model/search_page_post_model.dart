import 'package:flutter_infinite_list/features/search_page/domain/entities/search_page_post.dart';

class SearchPostModel extends SearchPost {
  SearchPostModel({
    int id,
    String title,
    String posterUrl,
  }): super(
    id: id,
    title: title,
    posterUrl: posterUrl,
  );

  factory SearchPostModel.fromJson(Map<String, dynamic> json) {
    final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
    return SearchPostModel(
      posterUrl: json['poster_path'],
      title: json['title'],
      id: json['id'],
    );
  }
}