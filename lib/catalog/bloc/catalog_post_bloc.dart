import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_infinite_list/catalog/bloc/bloc.dart';
import 'package:flutter_infinite_list/catalog/models/models.dart';
import 'package:tuple/tuple.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  Stream<PostState> transformEvents(
    Stream<PostEvent> events,
    Stream<PostState> Function(PostEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(1);
          yield PostLoaded(posts: posts.item2, hasReachedMax: false, page: posts.item1);
        }
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts(currentState.page+1);
          yield posts.item2.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
            posts: currentState.posts + posts.item2,
            hasReachedMax: false,
            page: posts.item1
          );
        }
      } catch (_) {
        yield PostError();
      }
    }
    if (event is Refresh) {
      if (currentState is PostLoaded) {
        try {
          final posts = await _fetchPosts(1);
          //yield PostLoaded(posts: [], hasReachedMax: false);
          yield PostRefreshLoading();
          yield PostLoaded(posts: posts.item2, hasReachedMax: false);
        }
        catch (_) {
          yield PostError();
        }
    }
  }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<Tuple2<int,List<Post>>> _fetchPosts(int page) async {
    final String _apiKey = 'PUT KEY HERE';
    final response = await httpClient.get(
                                          'https://api.themoviedb.org/3/movie/popular?'
                                          'api_key=$_apiKey&'
                                          'language=en-US&'
                                          'page=$page');
    if (response.statusCode == 200) {
      final data = (json.decode(response.body))['results'] as List;
      final int pag = (json.decode(response.body))['page'];
      final finalList = data.map((rawPost) {
        return Post.fromJson(rawPost);
      }).toList();
      final totalresult = Tuple2<int,List<Post>>(pag,finalList);
      return totalresult;
    } else {
      throw Exception('error fetching posts');
    }
  }
}

