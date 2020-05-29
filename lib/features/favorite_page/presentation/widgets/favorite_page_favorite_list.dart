import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/bloc/bloc.dart';
import 'favorite_page_widgets.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritePageBloc,FavoritePageState>(
      builder: (context, state) {
        if (state is FavoritePageLoadingState){
          return CircularProgressIndicator();
        }
        if(state is FavoritePageLoadedState){
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) => ListItem(
                                                post: state.posts[index],
                                                index: index,
            ),
          );
        }
        return Text('Something went wrong!');
      },
    );
  }

}