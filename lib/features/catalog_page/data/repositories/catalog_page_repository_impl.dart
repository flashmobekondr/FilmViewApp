import 'package:flutter_infinite_list/core/network/network_info.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_infinite_list/features/catalog_page/data/model/catalog_page_post_model.dart';
import 'package:flutter_infinite_list/features/catalog_page/domain/entities/catalog_page_post.dart';
import 'package:flutter_infinite_list/features/catalog_page/domain/repositories/catalog_page_repository.dart';
import 'package:flutter_infinite_list/features/catalog_page/data/datasources/catalog_page_remote_data_source.dart';

class CatalogPageRepositoryImpl extends CatalogPageRepository {
  final NetworkInfo networkInfo;
  final CatalogPageRemoteDataSource remoteDataSource;

  CatalogPageRepositoryImpl({
    this.networkInfo,
    this.remoteDataSource,
  });

  @override
  Future<Tuple2<int,List<PostModel>>> fetchPost(int page) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.fetchPosts(page);
      }
      catch(e) {
        throw Exception('error fetching data');
      }
    } else {
      throw Exception('error no connection');
    }
  }

}


