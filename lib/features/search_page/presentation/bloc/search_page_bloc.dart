import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_infinite_list/features/search_page/domain/usecases/search_page_get_post.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  final GetPostSearch post;
  SearchPageBloc({this.post});

  @override
  Stream<SearchPageState> transformEvents(
      Stream<SearchPageEvent> events,
      Stream<SearchPageState> Function(SearchPageEvent event) next,
      ) {
    return events
        .debounceTime(
      Duration(milliseconds: 300),
    )
        .switchMap(next);
  }

  @override
  SearchPageState get initialState => SearchPageStateEmpty();

  @override
  Stream<SearchPageState> mapEventToState(SearchPageEvent event) async* {
    if (event is SearchPageTextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchPageStateEmpty();
      } else {
        yield SearchPageStateLoading();
        try {
          await Future<void>.delayed(Duration(seconds: 2));
          final result = await post.fetch(searchTerm);
          yield SearchPageStateSuccess(items: result);
        }
        catch (error) {
          yield SearchPageStateError(error);
        }
      }
    }
  }
}
