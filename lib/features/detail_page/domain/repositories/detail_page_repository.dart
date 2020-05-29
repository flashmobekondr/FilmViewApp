import 'package:flutter_infinite_list/features/detail_page/data/model/detail_page_post_model.dart';
import 'package:flutter_infinite_list/features/detail_page/domain/entities/detail_page_post.dart';

abstract class DetailPageRepository {
  Future<DetailPostModel> fetchPost (
      int id,
      );
}