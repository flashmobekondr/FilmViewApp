import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/catalog/catalog.dart';

import 'package:flutter_infinite_list/favorite/favorite.dart';
import 'package:flutter_infinite_list/details/details.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Posts'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _PostList()

            ),
          ],
        ),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc,FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading){
          return CircularProgressIndicator();
        }
        if(state is FavoriteLoaded){
          return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) => _ListItem(post: state.posts[index]),
          );
        }
        return Text('Something went wrong!');
      },
    );
  }

}
class _ListItem extends StatelessWidget {
  final Post post;
  _ListItem({this.post});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: InkWell(
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
          margin: EdgeInsets.all(5.0),
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
            ],
          ),
        ),
      ),
      key: Key(post.title),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        BlocProvider.of<FavoriteBloc>(context).add(RemovePost(post));
        Scaffold
            .of(context)
            .showSnackBar(
            SnackBar(
              content: Text('Dismissed'),
              action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () =>
                      BlocProvider.of<FavoriteBloc>(context).add(AddPost(post))
              ),
            )
        );
      },
    );
  }
}
