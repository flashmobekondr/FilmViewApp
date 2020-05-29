import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/catalog_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/catalog_page/presentation/widgets/catalog_page_widgets.dart';


class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> /*with SingleTickerProviderStateMixin*/ {
  //TabController _tabController;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  CatalogPageBloc _catalogPageBloc;

  @override
  void initState() {
    super.initState();
    //_tabController= TabController(length: 3,vsync: this);
    _scrollController.addListener(_onScroll);
    _catalogPageBloc = BlocProvider.of<CatalogPageBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        bottom: TabBar(
//        controller: _tabController,
//          tabs: [
//            Tab(icon: new Icon(Icons.home)),
//            Tab(icon: new Icon(Icons.store)),
//            Tab(icon: new Icon(Icons.delete_forever)),
//          ],
//      ),
        actions: <Widget>[
          BadgeButton(),
        ],
        title: Text('Posts'),
      ),
      body: BlocBuilder<CatalogPageBloc, CatalogPageState>(
        builder: (context, state) {
          if (state is CatalogPagePostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is CatalogPagePostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return RefreshIndicator(
              onRefresh: ()=>_refreshLost(),
              child: GridList(
                state: state,
                controller: _scrollController,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _refreshLost() async {
    await Future.delayed(Duration(seconds: 1));
    BlocProvider.of<CatalogPageBloc>(context).add(CatalogPageRefreshEvent());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _catalogPageBloc.add(CatalogPageRefreshEvent());
    }
  }
}