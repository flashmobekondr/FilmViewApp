import 'package:equatable/equatable.dart';

class SearchPost extends Equatable {
  final int id;
  final String title;
  final String posterUrl;

  const SearchPost({this.title,this.id,this.posterUrl});

  factory SearchPost.fromJson(Map<String, dynamic> json) {
    final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
    return SearchPost(
      posterUrl: json['poster_path'],
      title: json['title'],
      id: json['id'],
    );
  }

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'SearchPost { title: $title }';

}