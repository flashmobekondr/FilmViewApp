
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/search/search.dart';
import 'package:flutter_infinite_list/catalog/catalog.dart';
import 'package:flutter_infinite_list/details/details.dart';

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          _SearchBar(),
          _SearchBody(),
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  SearchBloc _searchBloc;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
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
              TextChanged(text: text)
          );
        },
        decoration: InputDecoration(
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
    _searchBloc.add(TextChanged(text: ''));
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc,SearchState>(
      builder: (context,state) {
        if (state is SearchStateLoading) {
          return Flexible(child: Center(child: CircularProgressIndicator()));
        }
        if (state is SearchStateError) {
          return Text(state.error);
        }
        if (state is SearchStateSuccess) {
          return state.items.isEmpty
                ? Text('No result')
                : Expanded(child: _SearchResult(items: state.items,),);

        }
        return Flexible(child: Center(child: Text('Enter movie title to search')));
      },
    );
  }
}

class _SearchResult extends StatelessWidget {
  final List<SearchPost> items;
  _SearchResult({this.items});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () =>
                Navigator
                .of(context)
                .push(MaterialPageRoute(
              builder: (context) {
                BlocProvider.of<DetailsBloc>(context).add(GetDetails(id: items[index].id));
                return DetailScreenNew();
              },
            )
            ),
            //leading: Text('${items[index].id}'),
            //leading: Image.network(items[index].posterUrl),
            title: Text('${items[index].title}'),
          );
        }
    );
  }
}



