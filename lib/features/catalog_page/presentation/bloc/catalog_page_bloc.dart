import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_infinite_list/features/catalog_page/domain/usecases/catalog_page_get_post.dart';

class CatalogPageBloc extends Bloc<CatalogPageEvent, CatalogPageState> {
  final GetPostCatalog post;
  CatalogPageBloc({this.post});

  @override
  CatalogPageState get initialState => CatalogPagePostUninitialized();

  @override
  Stream<CatalogPageState> transformEvents(
      Stream<CatalogPageEvent> events,
      Stream<CatalogPageState> Function(CatalogPageEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  bool _hasReachedMax(CatalogPageState state) =>
      state is CatalogPagePostLoaded && state.hasReachedMax;

  @override
  Stream<CatalogPageState> mapEventToState(CatalogPageEvent event) async* {
    final currentState = state;
    if (event is CatalogPageFetchEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is CatalogPagePostUninitialized) {
          final posts = await post.fetch(1);
          yield CatalogPagePostLoaded(posts: posts.item2, hasReachedMax: false, page: posts.item1);
        }
        if (currentState is CatalogPagePostLoaded) {
          final posts = await post.fetch(currentState.page+1);
          yield posts.item2.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : CatalogPagePostLoaded(
              posts: currentState.posts + posts.item2,
              hasReachedMax: false,
              page: posts.item1
          );
        }
      } catch (_) {
        yield CatalogPagePostError();
      }
    }
    if (event is CatalogPageRefreshEvent) {
      if (currentState is CatalogPagePostLoaded) {
        try {
          final posts = await post.fetch(1);
          //yield PostLoaded(posts: [], hasReachedMax: false);
          //yield CatalogPagePostRefreshLoading();
          yield CatalogPagePostLoaded(posts: posts.item2, hasReachedMax: false, page: 1);
        }
        catch (_) {
          yield CatalogPagePostError();
        }
      }
    }
  }
}
