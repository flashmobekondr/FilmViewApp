import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/catalog/catalog.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteLoading extends FavoriteState {


  @override
  List<Object> get props => [];
}

class FavoriteLoaded extends FavoriteState {
  final List<Post> posts;

  const FavoriteLoaded({this.posts});

  int get totalAmount => posts.fold(0, (previousValue, element) => previousValue + element.count);


  @override
  List<Object> get props => [posts];
}

class FavoriteError extends FavoriteState {
  @override
  List<Object> get props => [];

}