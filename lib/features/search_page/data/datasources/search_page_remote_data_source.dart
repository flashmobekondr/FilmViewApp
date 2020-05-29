import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_infinite_list/features/search_page/data/model/search_page_post_model.dart';

abstract class SearchPageRemoteDataSource {
  Future<List<SearchPostModel>> fetchSearch(
      String query,
      );
}

class SearchPageRemoteDataSourceImpl extends SearchPageRemoteDataSource {
  final http.Client client;
  SearchPageRemoteDataSourceImpl({this.client});

  @override
  Future<List<SearchPostModel>> fetchSearch(String query) async {
    final String _apiKey = 'dc1c15a118b26847384bae6f411a98fe';
    final response = await client.get('https://api.themoviedb.org/3/search/movie?'
                                      'api_key=$_apiKey&'
                                      'language=en-US&'
                                      'query=$query&'
                                      'page=1&'
                                      'include_adult=false');
    if (response.statusCode == 200) {
      final data = (json.decode(response.body))['results'] as List;
      return data.map((rawSearch) {
        return SearchPostModel.fromJson(rawSearch);
      }
      ).toList();
    }
    else {
      throw Exception('error fetching posts');
    }
  }
}