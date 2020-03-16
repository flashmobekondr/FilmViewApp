import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/search/models/search_post.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateSuccess extends SearchState {
  final List<SearchPost> items;
  SearchStateSuccess({this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess: {items: ${items.length}';
}

class SearchStateError extends SearchState {
  final String error;

  const SearchStateError(this.error);

  @override
  List<Object> get props => [error];
}
