import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/widgets/search_page_widgets.dart';

class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageBloc,SearchPageState>(
      builder: (context,state) {
        if (state is SearchPageStateLoading) {
          return Flexible(child: Center(child: CircularProgressIndicator()));
        }
        if (state is SearchPageStateError) {
          return Text(state.error);
        }
        if (state is SearchPageStateSuccess) {
          return state.items.isEmpty
              ? Text('No result')
              : Expanded(
                    child: SearchResult(items: state.items,),
          );

        }
        return Flexible(
            child: Center(
                child: Text('Enter movie title to search')
            )
        );
      },
    );
  }
}