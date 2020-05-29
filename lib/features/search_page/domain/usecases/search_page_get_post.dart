import 'package:flutter_infinite_list/features/search_page/domain/repositories/search_page_repository.dart';
import 'package:flutter_infinite_list/features/search_page/data/model/search_page_post_model.dart';

class GetPostSearch {
  final SearchPageRepository repository;
  GetPostSearch({this.repository});

  Future<List<SearchPostModel>> fetch (
      String query,
      ) async {
    try {
      return await repository.fetchPost(query);
    } catch (_) {
      throw Exception('error fetching data');
    }
  }
}