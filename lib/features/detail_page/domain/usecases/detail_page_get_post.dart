import 'package:flutter_infinite_list/features/detail_page/domain/repositories/detail_page_repository.dart';
import 'package:flutter_infinite_list/features/detail_page/data/model/detail_page_post_model.dart';

class GetPostDetail {
  final DetailPageRepository repository;
  GetPostDetail({this.repository});

  Future<DetailPostModel> fetch (
      int id,
      ) async {
    try {
      return await repository.fetchPost(id);
    } catch (_) {
      throw Exception('error fetching data');
    }
  }
}