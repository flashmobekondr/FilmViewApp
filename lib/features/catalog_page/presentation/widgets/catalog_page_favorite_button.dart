import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/catalog_page/data/model/catalog_page_post_model.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/catalog_page/presentation/widgets/catalog_page_widgets.dart';

class FavoriteButton extends StatelessWidget {
  final PostModel post;
  FavoriteButton({this.post});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritePageBloc,FavoritePageState>(
      builder: (context, state) {
        if (state is FavoritePageLoadingState){
          return CircularProgressIndicator();
        }
        if (state is FavoritePageLoadedState){
          return IconButton(
            color: Colors.red,
            icon: Icon(
              state.posts.contains(post)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: state.posts.contains(post)
                ? () => BlocProvider.of<FavoritePageBloc>(context).add(FavoritePageRemovePostEvent(post))
                : () => BlocProvider.of<FavoritePageBloc>(context).add(FavoritePageAddPostEvent(post)),
          );
        }
        return Text('Something went wrong!');
      },
    );
  }
}