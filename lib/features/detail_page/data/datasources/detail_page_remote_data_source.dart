import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_infinite_list/features/detail_page/data/model/detail_page_post_model.dart';

abstract class DetailPageRemoteDataSource {
  Future<DetailPostModel> fetchDetail (
      int id,
      );
}

class DetailPageRemoteDataSourceImpl implements DetailPageRemoteDataSource {
  final http.Client client;
  DetailPageRemoteDataSourceImpl({this.client});
  @override
  Future<DetailPostModel> fetchDetail(int id) async {
    final String _apiKey = 'dc1c15a118b26847384bae6f411a98fe';
    final response = await client.get('https://api.themoviedb.org/3/movie/$id?'
                                    'api_key=$_apiKey&'
                                    'language=en-US');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DetailPostModel.fromJson(data);
    }
    else {
      throw Exception('error fetching posts');
    }
  }
}

