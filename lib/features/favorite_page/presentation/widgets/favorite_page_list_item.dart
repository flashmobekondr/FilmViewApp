import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/detail_page/presentation/pages/detail_page.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_infinite_list/features/catalog_page/data/model/catalog_page_post_model.dart';
import 'package:flutter_infinite_list/features/detail_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/bloc/bloc.dart';

class ListItem extends StatelessWidget {
  final PostModel post;
  final int index;
  ListItem({this.post,this.index});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: InkWell(
        onTap: () {
          Navigator
              .of(context)
              .push(MaterialPageRoute(
            builder:(context){
              BlocProvider.of<DetailPageBloc>(context).add(DetailPageGetDetail(id: post.id));
              return DetailPage(id: post.id,);
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
        padding: EdgeInsets.only(right: 20.0),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Text(
          'Delete',
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white),
        ),
      ),
      onDismissed: (direction) {
        BlocProvider.of<FavoritePageBloc>(context)
            .add(FavoritePageRemovePostEvent(post));
        Scaffold
            .of(context)
            .showSnackBar(
            SnackBar(
              content: Text('Dismissed'),
              action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () =>
                      BlocProvider.of<FavoritePageBloc>(context)
                          .add(FavoritePageAddPostAgain(post,index))
              ),
            )
        );
      },
    );
  }
}