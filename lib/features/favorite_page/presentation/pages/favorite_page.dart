import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/widgets/favorite_page_widgets.dart';

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
                child: FavoriteList()
            ),
          ],
        ),
      ),
    );
  }
}