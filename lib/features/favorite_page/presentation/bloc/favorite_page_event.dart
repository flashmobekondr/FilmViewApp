import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/features/catalog_page/data/model/catalog_page_post_model.dart';

abstract class FavoritePageEvent extends Equatable {
  const FavoritePageEvent();
}

class FavoritePageLoadEvent extends FavoritePageEvent {
  @override
  List<Object> get props => [];
}

class FavoritePageAddPostEvent extends FavoritePageEvent {
  final PostModel post;

  const FavoritePageAddPostEvent(this.post);

  @override
  List<Object> get props => [post];
}

class FavoritePageAddPostAgain extends FavoritePageEvent {
  final PostModel post;
  final int index;
  const FavoritePageAddPostAgain(this.post,this.index);

  @override
  List<Object> get props => [post,index];
}

class FavoritePageRemovePostEvent extends FavoritePageEvent {
  final PostModel post;

  const FavoritePageRemovePostEvent(this.post);

  @override
  List<Object> get props => [post];
}