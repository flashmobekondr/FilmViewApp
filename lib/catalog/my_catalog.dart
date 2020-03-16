import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_infinite_list/favorite/bloc/bloc.dart';
import 'package:flutter_infinite_list/favorite/favorite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/catalog/catalog.dart';
import 'package:flutter_infinite_list/search/search.dart';
import 'package:badges/badges.dart';
import 'package:flutter_infinite_list/details/details.dart';
import 'package:transparent_image/transparent_image.dart';


class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
   int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
    BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(httpClient: http.Client()),
      child: SearchForm(),
    ),
  ];

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    print('Reload');
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
          BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          title: Text('Favorite'),
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
    ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> /*with SingleTickerProviderStateMixin*/ {
  //TabController _tabController;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    //_tabController= TabController(length: 3,vsync: this);
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    print('Really Reload');
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
              IconButton(
                    icon: Badge(
                      child:  Icon(Icons.dehaze),
                      badgeContent: BlocBuilder<FavoriteBloc,FavoriteState>(
                           builder:  (context, state) {
                            if(state is FavoriteLoaded){
                            return Text('${state.totalAmount}');
                    }
                            return Container();
                  },
                ),
              ),
              onPressed: () => Navigator
                  .of(context)
                  .pushNamed('/favorite'),
            ),
        ],
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return RefreshIndicator(
              onRefresh: ()=>_refreshLost(),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  print('{Индекс:$index}');
                  return index >= state.posts.length
                      ? BottomLoader()
                      : PostWidget(post: state.posts[index],index: index);
                },
                //itemExtent: 100.0,
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
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
  Future _refreshLost() async {
    await Future.delayed(Duration(seconds: 1));
    BlocProvider.of<PostBloc>(context).add(Refresh());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(Fetch());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;
  final int index;

  const PostWidget({Key key, @required this.post, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return InkWell(
       onTap: () {
         Navigator
             .of(context)
             .push(MaterialPageRoute(
           builder:(context){
             BlocProvider.of<DetailsBloc>(context).add(GetDetails(id: post.id));
             return DetailScreenNew();
           },
         )
         );
       },
       child: Container(
         margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 100.0,
        child: Row(
          children: <Widget>[
            FadeInImage.memoryNetwork(
              height: 100.0,
              width: 100.0,
              placeholder: kTransparentImage,
              image: post.posterUrl,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      post.title,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Expanded(
                      child: Text(
                        post.body,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ),
            ),
            _favoriteButton(post: post,),
          ],
        ),
    ),
     );
  }
}
class DetailScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context).settings.arguments;
    return BlocBuilder<PostBloc,PostState>(
      builder:(context,state){
        if(state is PostLoaded){
          return Scaffold(
            appBar: AppBar(
              title: Text('${state.posts[index].title}'),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Image.network(state.posts[index].posterUrl),
                  Text('${state.posts[index].title}'),
                  Text('${state.posts[index].body}'),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

}
class _favoriteButton extends StatelessWidget {
  final Post post;
  _favoriteButton({this.post});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc,FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading){
          return CircularProgressIndicator();
        }
        if (state is FavoriteLoaded){
          return IconButton(
            color: Colors.red,
            icon: Icon(
              state.posts.contains(post)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: state.posts.contains(post)
                  ? () => BlocProvider.of<FavoriteBloc>(context).add(RemovePost(post))
                  : () => BlocProvider.of<FavoriteBloc>(context).add(AddPost(post)),
          );
        }
        return Text('Something went wrong!');
      },
    );
  }

}
