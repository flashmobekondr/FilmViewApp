import 'package:bloc/bloc.dart';
import 'package:flutter_infinite_list/favorite/bloc/bloc.dart';


class FavoriteBloc extends Bloc<FavoriteEvent,FavoriteState> {
  @override
  FavoriteState get initialState => FavoriteLoading();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event,) async* {
    if(event is LoadFavorite){
      yield* _mapLoadFavoriteToState();
    } else if (event is AddPost){
      yield* _mapAddPostToState(event);
    }
    else if (event is RemovePost){
      yield* _mapRemovePostToState(event);
    }
  }

  Stream<FavoriteState> _mapLoadFavoriteToState() async*{
    yield FavoriteLoading();
    try {
      await Future.delayed(Duration(seconds: 1));
      yield FavoriteLoaded(posts:[]);
    }
    catch (_) {
      FavoriteError();
    }

  }

  Stream<FavoriteState> _mapAddPostToState(AddPost event) async*{
    final currentState = state;
    if (currentState is FavoriteLoaded) {
      try {
        yield FavoriteLoaded(posts: List.from(currentState.posts)..add(event.post));
      }
      catch (_) {
        FavoriteError();
      }
    }
  }

  Stream<FavoriteState> _mapRemovePostToState(RemovePost event) async*{
    final currentState = state;
    if (currentState is FavoriteLoaded) {
      try {
        yield FavoriteLoaded(posts: List.from(currentState.posts)..remove(event.post));
      }
      catch (_) {
        FavoriteError();
      }
    }
  }
}