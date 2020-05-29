import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/widgets/search_page_widgets.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          SearchBar(),
          SearchBody(),
        ],
      ),
    );
  }
}