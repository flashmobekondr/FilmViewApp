import 'package:flutter_infinite_list/features/search_page/data/model/search_page_post_model.dart';
import 'package:flutter_infinite_list/features/search_page/domain/entities/search_page_post.dart';

abstract class SearchPageRepository {
  Future<List<SearchPostModel>> fetchPost (
      String query,
      );
}