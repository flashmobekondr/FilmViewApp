import 'package:equatable/equatable.dart';

class SearchPost extends Equatable {
  final int id;
  final String title;
  final String posterUrl;

  const SearchPost({this.title, this.id, this.posterUrl});

  @override
  List<Object> get props => [id,title,posterUrl];
}