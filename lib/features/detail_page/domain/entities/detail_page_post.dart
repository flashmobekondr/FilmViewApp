import 'package:equatable/equatable.dart';

class DetailPost extends Equatable {
  final int id;
  final String title;
  final String posterUrl;
  final String body;

  const DetailPost({this.id,this.title,this.posterUrl,this.body});

  @override
  List<Object> get props => [id,title,posterUrl,body];
}