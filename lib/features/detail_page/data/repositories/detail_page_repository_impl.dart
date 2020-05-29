import 'package:flutter_infinite_list/core/network/network_info.dart';
import 'package:flutter_infinite_list/features/detail_page/data/model/detail_page_post_model.dart';
import 'package:flutter_infinite_list/features/detail_page/domain/entities/detail_page_post.dart';
import 'package:flutter_infinite_list/features/detail_page/domain/repositories/detail_page_repository.dart';
import 'package:flutter_infinite_list/features/detail_page/data/datasources/detail_page_remote_data_source.dart';

class DetailPageRepositoryImpl extends DetailPageRepository {
  final NetworkInfo networkInfo;
  final DetailPageRemoteDataSource remoteDataSource;
  DetailPageRepositoryImpl({
    this.networkInfo,
    this.remoteDataSource});

  @override
  Future<DetailPostModel> fetchPost(int id) async{
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.fetchDetail(id);
      }
      catch(e) {
        throw Exception('error fetching data');
      }
    } else {
      throw Exception('error no connection');
    }
  }
}