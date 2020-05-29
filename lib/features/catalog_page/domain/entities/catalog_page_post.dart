import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final String posterUrl;
  final int count;

  Post({this.id,this.title,this.body,this.posterUrl,this.count});

  @override
  List<Object> get props => [id,title,body,posterUrl,count];
}