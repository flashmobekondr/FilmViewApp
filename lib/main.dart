import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_infinite_list/catalog/catalog.dart';
import 'package:flutter_infinite_list/favorite/favorite.dart';
import 'package:flutter_infinite_list/details/details.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailsBloc>(
          create: (context) => DetailsBloc(),
        ),
        BlocProvider<PostBloc>(
          create: (context) =>PostBloc(httpClient: http.Client())..add(Fetch()),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc()..add(LoadFavorite()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'FilmView',
        initialRoute: '/',
        routes: {
          '/': (context) => CatalogPage(),
          '/favorite': (context) => FavoritePage(),
        },
      ),
    );
  }
}
