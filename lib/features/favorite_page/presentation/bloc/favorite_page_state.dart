import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/features/catalog_page/data/model/catalog_page_post_model.dart';

abstract class FavoritePageState extends Equatable {
  const FavoritePageState();
}

class FavoritePageLoadingState extends FavoritePageState {
  @override
  List<Object> get props => [];
}

class FavoritePageLoadedState extends FavoritePageState {
  final List<PostModel> posts;

  const FavoritePageLoadedState({this.posts});

  int get totalAmount => posts.fold(0, (previousValue, element) => previousValue + element.count);


  @override
  List<Object> get props => [posts];
}

class FavoritePageError extends FavoritePageState {
  @override
  List<Object> get props => [];
}