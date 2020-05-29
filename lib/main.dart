import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter_infinite_list/injection_container.dart' as di;
import 'package:flutter_infinite_list/features/catalog_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/detail_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/page_switcher/page_switcher_bottom_bar.dart';
import 'package:flutter_infinite_list/core/bloc/simple_bloc_delegate.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App1());
}

class App1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailPageBloc>(
          create: (context) => di.sl<DetailPageBloc>(),
        ),
        BlocProvider<CatalogPageBloc>(
          create: (context) =>di.sl<CatalogPageBloc>()..add(CatalogPageFetchEvent()),
        ),
        BlocProvider<FavoritePageBloc>(
          create: (context) => FavoritePageBloc()..add(FavoritePageLoadEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'FilmView',
        initialRoute: '/',
        routes: {
          '/': (context) => PageSwitcher(),
        },
      ),
    );
  }
}

