import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/search/bloc/bloc.dart';
import 'package:flutter_infinite_list/search/models/search_post.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState> {
  final http.Client httpClient;
  SearchBloc({this.httpClient});

  @override
  Stream<SearchState> transformEvents(
      Stream<SearchEvent> events,
      Stream<SearchState> Function(SearchEvent event) next,
      ) {
    return events
        .debounceTime(
      Duration(milliseconds: 300),
    )
        .switchMap(next);
  }

  @override
  SearchState get initialState => SearchStateEmpty();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          //await Future<void>.delayed(Duration(seconds: 2));
          final result = await _fetchSearch(searchTerm);
          yield SearchStateSuccess(items: result);
        }
        catch (error) {

        }
      }
    }
  }

  Future<List<SearchPost>> _fetchSearch(String query) async {
    final String _apiKey = 'PUT KEY HERE';
    final response = await httpClient.get('https://api.themoviedb.org/3/search/movie?'
                                          'api_key=$_apiKey&'
                                          'language=en-US&'
                                          'query=$query&'
                                          'page=1&'
                                          'include_adult=false');
    if (response.statusCode == 200) {
      final data = (json.decode(response.body))['results'] as List;
      return data.map((rawSearch) {
        return SearchPost.fromJson(rawSearch);
      }
      ).toList();
    }
    else {
      throw Exception('error fetching posts');
    }
  }
}

