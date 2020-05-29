import 'package:equatable/equatable.dart';

abstract class CatalogPageEvent extends Equatable {
  const CatalogPageEvent();

  @override
  List<Object> get props => [];
}

class CatalogPageFetchEvent extends CatalogPageEvent {}
class CatalogPageRefreshEvent extends CatalogPageEvent {}

