import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/details/models/details_post.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();
  @override
  List<Object> get props => [];
}
class DetailsStateEmpty extends DetailsState {}

class DetailsStateLoading extends DetailsState {}

class DetailsStateSuccess extends DetailsState {
  final DetailsPost item;

  DetailsStateSuccess({this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'DetailsStateSuccess: {items: $item';
 }

class DetailsStateError extends DetailsState {
  final String error;

  const DetailsStateError(this.error);

  @override
  List<Object> get props => [error];
}
