import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final String posterUrl;
  final int count = 1;

  factory Post.fromJson(Map<String, dynamic> json) {
    final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['overview'],
      posterUrl: _posterBodyUrl + json['poster_path'],
    );

  }

  const Post({this.id, this.title, this.body,this.posterUrl});

  @override
  List<Object> get props => [id, title, body];

  @override
  String toString() => 'Post { id: $id,$title }';
}
