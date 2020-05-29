import 'package:flutter_infinite_list/features/catalog_page/domain/repositories/catalog_page_repository.dart';
import 'package:flutter_infinite_list/features/catalog_page/data/model/catalog_page_post_model.dart';
import 'package:tuple/tuple.dart';

class GetPostCatalog {
  final CatalogPageRepository repository;
  GetPostCatalog({this.repository});

  Future<Tuple2<int,List<PostModel>>> fetch (
      int page,
      ) async {
    try {
      return await repository.fetchPost(page);
    } catch (_) {
      throw Exception('error fetching data');
    }
  }
}