import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:flutter_infinite_list/core/network/network_info.dart';

import 'package:flutter_infinite_list/features/catalog_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/detail_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/bloc/bloc.dart';

import 'package:flutter_infinite_list/features/catalog_page/data/datasources/catalog_page_remote_data_source.dart';
import 'package:flutter_infinite_list/features/detail_page/data/datasources/detail_page_remote_data_source.dart';
import 'package:flutter_infinite_list/features/search_page/data/datasources/search_page_remote_data_source.dart';

import 'package:flutter_infinite_list/features/catalog_page/domain/usecases/catalog_page_get_post.dart';
import 'package:flutter_infinite_list/features/detail_page/domain/usecases/detail_page_get_post.dart';
import 'package:flutter_infinite_list/features/search_page/domain/usecases/search_page_get_post.dart';

import 'package:flutter_infinite_list/features/catalog_page/domain/repositories/catalog_page_repository.dart';
import 'package:flutter_infinite_list/features/detail_page/domain/repositories/detail_page_repository.dart';
import 'package:flutter_infinite_list/features/search_page/domain/repositories/search_page_repository.dart';

import 'package:flutter_infinite_list/features/catalog_page/data/repositories/catalog_page_repository_impl.dart';
import 'package:flutter_infinite_list/features/detail_page/data/repositories/detail_page_repository_impl.dart';
import 'package:flutter_infinite_list/features/search_page/data/repositories/search_page_repository_impl.dart';

final sl = GetIt.instance;
Future<void> init () async {
  //Bloc
  sl.registerFactory(() => CatalogPageBloc(post: sl()));
  sl.registerFactory(() => DetailPageBloc(post: sl()));
  sl.registerFactory(() => SearchPageBloc(post: sl()));

  //Use cases
  sl.registerLazySingleton(() => GetPostCatalog(repository: sl()));
  sl.registerLazySingleton(() => GetPostDetail(repository: sl()));
  sl.registerLazySingleton(() => GetPostSearch(repository: sl()));

  //Repository
  sl.registerLazySingleton<CatalogPageRepository>(
          () => CatalogPageRepositoryImpl(
            networkInfo: sl(),
            remoteDataSource: sl(),
          )
  );
  sl.registerLazySingleton<DetailPageRepository>(
          () => DetailPageRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      )
  );
  sl.registerLazySingleton<SearchPageRepository>(
          () => SearchPageRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      )
  );

  //Data sources
  sl.registerLazySingleton<CatalogPageRemoteDataSource>(
          () => CatalogPageRemoteDataSourceImpl(
            client: sl(),
          ));
  sl.registerLazySingleton<DetailPageRemoteDataSource>(
          () => DetailPageRemoteDataSourceImpl(
        client: sl(),
      ));
  sl.registerLazySingleton<SearchPageRemoteDataSource>(
          () => SearchPageRemoteDataSourceImpl(
        client: sl(),
      ));

  //Core
  sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(
          connectionChecker: sl()
      )
  );

  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}