import 'package:equatable/equatable.dart';

abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();
}

class SearchPageTextChanged extends SearchPageEvent {
  final String text;

  const SearchPageTextChanged({this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'SearchPageTextChanged: {text: $text}';
}