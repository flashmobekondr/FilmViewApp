import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:flutter_infinite_list/features/detail_page/domain/usecases/detail_page_get_post.dart';
import 'package:flutter_infinite_list/features/detail_page/data/model/detail_page_post_model.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  final Map<int, DetailPostModel> mapResults = Map<int,DetailPostModel>();
  final GetPostDetail post;
  DetailPageBloc({this.post});
  @override
  DetailPageState get initialState => DetailPageStateEmpty();

  @override
  Stream<DetailPageState> mapEventToState(DetailPageEvent event) async* {
    if(event is DetailPageGetDetail) {
      yield DetailPageStateLoading();
      try {
        final result = await post.fetch(event.id);
        //mapResults[event.id] = result;
        mapResults.putIfAbsent(event.id, () => result);
        yield DetailPageStateSuccess(item: mapResults);
      }
      catch(error) {
        yield DetailPageStateError(error);
      }
    }
  }
}
