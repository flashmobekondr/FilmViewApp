import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class GetDetails extends DetailsEvent {
  final int id;

  const GetDetails({this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'GetDetails: {id: $id}';
}