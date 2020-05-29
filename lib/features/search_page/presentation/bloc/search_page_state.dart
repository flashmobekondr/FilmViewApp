import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/features/search_page/data/model/search_page_post_model.dart';

abstract class SearchPageState extends Equatable {
  const SearchPageState();
  @override
  List<Object> get props => [];
}

class SearchPageStateEmpty extends SearchPageState {}

class SearchPageStateLoading extends SearchPageState {}

class SearchPageStateSuccess extends SearchPageState {
  final List<SearchPostModel> items;
  SearchPageStateSuccess({this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchPageStateSuccess: {items: ${items.length}';
}

class SearchPageStateError extends SearchPageState {
  final String error;

  const SearchPageStateError(this.error);

  @override
  List<Object> get props => [error];
}
