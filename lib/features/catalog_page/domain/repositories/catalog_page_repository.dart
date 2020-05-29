import 'package:flutter_infinite_list/features/catalog_page/data/model/catalog_page_post_model.dart';
import 'package:flutter_infinite_list/features/catalog_page/domain/entities/catalog_page_post.dart';
import 'package:tuple/tuple.dart';

abstract class CatalogPageRepository {
  Future<Tuple2<int,List<PostModel>>> fetchPost (
      int page,
      );
}