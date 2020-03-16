import 'package:equatable/equatable.dart';


class DetailsPost extends Equatable {
  final int id;
  final String title;
  final String posterUrl;
  final String body;

  const DetailsPost({this.title,this.id,this.posterUrl,this.body});

    factory DetailsPost.fromJson(Map<String, dynamic> json) {
      final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
      return DetailsPost(
        id: json['id'],
        title: json['title'],
        posterUrl: _posterBodyUrl+ json['poster_path'],
        body: json['overview']
      );
  }

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'DetailsPost { title: $title }';

}