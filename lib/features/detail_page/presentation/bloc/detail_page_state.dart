import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/features/detail_page/data/model/detail_page_post_model.dart';

abstract class DetailPageState extends Equatable {
  const DetailPageState();
  @override
  List<Object> get props => [];
}

class DetailPageStateEmpty extends DetailPageState {}

class DetailPageStateLoading extends DetailPageState {}

class DetailPageStateSuccess extends DetailPageState {
  final Map<int, DetailPostModel> item;
  //final DetailsPost item;

  DetailPageStateSuccess({this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'DetailPageStateSuccess: {items: $item';
}

class DetailPageStateError extends DetailPageState {
  final String error;

  const DetailPageStateError(this.error);

  @override
  List<Object> get props => [error];
}
