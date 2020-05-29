import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/catalog_page/presentation/widgets/catalog_page_widgets.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/pages/favorite_page.dart';

class BadgeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Badge(
        child:  Icon(Icons.dehaze),
        badgeContent: BlocBuilder<FavoritePageBloc,FavoritePageState>(
          builder:  (context, state) {
            if(state is FavoritePageLoadedState){
              return Text('${state.totalAmount}');
            }
            return Container();
          },
        ),
      ),
      onPressed: () => Navigator
          .of(context)
          .push(MaterialPageRoute(
        builder: (context) => FavoritePage(),
      )
      ),
    );
  }
}
