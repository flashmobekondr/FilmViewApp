import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/details/bloc/bloc.dart';
import 'package:flutter_infinite_list/details/models/details_post.dart';

class DetailsBloc extends Bloc<DetailsEvent,DetailsState> {
  @override
  DetailsState get initialState => DetailsStateEmpty();

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if(event is GetDetails) {
      yield DetailsStateLoading();
      try {
        final result = await _fetchDetails(event.id);
        yield DetailsStateSuccess(item: result);
      }
      catch(error) {

      }
    }
  }
  Future<DetailsPost> _fetchDetails(int id) async {
    final String _apiKey='';
    final response = await http.get('https://api.themoviedb.org/3/movie/$id?'
                                    'api_key=$_apiKey&'
                                    'language=en-US');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DetailsPost.fromJson(data);
    }
    else {
      throw Exception('error fetching posts');
    }

  }
}