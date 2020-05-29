import 'package:flutter_infinite_list/core/network/network_info.dart';
import 'package:flutter_infinite_list/features/search_page/data/model/search_page_post_model.dart';
import 'package:flutter_infinite_list/features/search_page/domain/entities/search_page_post.dart';
import 'package:flutter_infinite_list/features/search_page/domain/repositories/search_page_repository.dart';
import 'package:flutter_infinite_list/features/search_page/data/datasources/search_page_remote_data_source.dart';

class SearchPageRepositoryImpl extends SearchPageRepository {
  final NetworkInfo networkInfo;
  final SearchPageRemoteDataSource remoteDataSource;

  SearchPageRepositoryImpl({
    this.networkInfo,
    this.remoteDataSource,
  });

  @override
  Future<List<SearchPostModel>> fetchPost(String query) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.fetchSearch(query);
      }
      catch(e) {
        throw Exception('error fetching data');
      }
    } else {
      throw Exception('error no connection');
    }
  }

}
