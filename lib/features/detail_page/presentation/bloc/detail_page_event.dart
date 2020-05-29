import 'package:equatable/equatable.dart';

abstract class DetailPageEvent extends Equatable {
  const DetailPageEvent();
}

class DetailPageGetDetail extends DetailPageEvent {
  final int id;

  const DetailPageGetDetail({this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'GetDetails: {id: $id}';
}