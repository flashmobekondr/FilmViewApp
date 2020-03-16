import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/catalog/catalog.dart';


abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class LoadFavorite extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class AddPost extends FavoriteEvent {
  final Post post;

  const AddPost(this.post);

  @override
  List<Object> get props => [post];
}

class RemovePost extends FavoriteEvent {
  final Post post;

  const RemovePost(this.post);

  @override
  List<Object> get props => [post];
}