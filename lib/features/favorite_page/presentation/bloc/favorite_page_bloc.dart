import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class FavoritePageBloc extends Bloc<FavoritePageEvent, FavoritePageState> {
  @override
  FavoritePageState get initialState => FavoritePageLoadingState();

  @override
  Stream<FavoritePageState> mapEventToState(FavoritePageEvent event,) async* {
    if(event is FavoritePageLoadEvent){
      yield* _mapLoadFavoriteToState();
    } else if (event is FavoritePageAddPostEvent || event is FavoritePageAddPostAgain){
      yield* _mapAddPostToState(event);
    }
    else if (event is FavoritePageRemovePostEvent){
      yield* _mapRemovePostToState(event);
    }
  }

  Stream<FavoritePageState> _mapLoadFavoriteToState() async* {
    yield FavoritePageLoadingState();
    try {
      await Future.delayed(Duration(seconds: 1));
      yield FavoritePageLoadedState(posts:[]);
    }
    catch (_) {
      yield FavoritePageError();
    }

  }

  Stream<FavoritePageState> _mapAddPostToState(FavoritePageEvent event) async*{
    final currentState = state;
    if (currentState is FavoritePageLoadedState) {
      try {
        if(event is FavoritePageAddPostEvent)
          yield FavoritePageLoadedState(posts: List.from(currentState.posts)..add(event.post));
        else if (event is FavoritePageAddPostAgain)
          yield FavoritePageLoadedState(posts: List.from(currentState.posts)..insert(event.index, event.post));
      }
      catch (_) {
        yield FavoritePageError();
      }
    }
  }

  Stream<FavoritePageState> _mapRemovePostToState(FavoritePageRemovePostEvent event) async*{
    final currentState = state;
    if (currentState is FavoritePageLoadedState) {
      try {
        yield FavoritePageLoadedState(posts: List.from(currentState.posts)..remove(event.post));
      }
      catch (_) {
        yield FavoritePageError();
      }
    }
  }
}
