import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import 'package:flutter_infinite_list/features/catalog_page/data/model/catalog_page_post_model.dart';

abstract class CatalogPageRemoteDataSource {
  Future<Tuple2<int,List<PostModel>>> fetchPosts (
      int page,
      );
}

class CatalogPageRemoteDataSourceImpl implements CatalogPageRemoteDataSource {
  final http.Client client;
  CatalogPageRemoteDataSourceImpl({this.client});

  @override
  Future<Tuple2<int,List<PostModel>>> fetchPosts(int page) async {
    final String _apiKey = 'dc1c15a118b26847384bae6f411a98fe';
    final response = await client.get(
        'https://api.themoviedb.org/3/movie/popular?'
            'api_key=$_apiKey&'
            'language=en-US&'
            'page=$page');
    if (response.statusCode == 200) {
      final data = (json.decode(response.body))['results'] as List;
      final int pag = (json.decode(response.body))['page'];

      final finalList = data.map((rawPost) {
        return PostModel.fromJson(rawPost);
      }).toList();

      return Tuple2<int, List<PostModel>>(pag, finalList);
    } else {
      throw Exception('error fetching posts');
    }
  }
}