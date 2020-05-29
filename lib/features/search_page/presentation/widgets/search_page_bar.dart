import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/widgets/search_page_widgets.dart';

class SearchBar extends StatefulWidget {
  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  SearchPageBloc _searchBloc;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchPageBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextField(
        controller: _textController,
        autocorrect: true,
        //autofocus: true,
        onChanged: (text) {
          _searchBloc.add(
              SearchPageTextChanged(text: text)
          );
        },
        decoration: InputDecoration(
          //border: InputBorder.none,
          //prefix: Icon(Icons.search),
          suffix: GestureDetector(
            child: Icon(Icons.clear),
            onTap: _onTapClear,
          ),
          hintText: 'Search movie...',
        ),
      ),
    );
  }

  void _onTapClear() {
    _textController.clear();
    _searchBloc.add(SearchPageTextChanged(text: ''));
  }
}