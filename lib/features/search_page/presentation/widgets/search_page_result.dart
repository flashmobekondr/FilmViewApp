import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/detail_page/presentation/pages/detail_page.dart';
import 'package:flutter_infinite_list/features/search_page/data/model/search_page_post_model.dart';
import 'package:flutter_infinite_list/features/detail_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/widgets/search_page_widgets.dart';


class SearchResult extends StatelessWidget {
  final List<SearchPostModel> items;
  SearchResult({this.items});

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
                    BlocProvider.of<DetailPageBloc>(context).add(DetailPageGetDetail(id: items[index].id));
                    return DetailPage(id: items[index].id,);
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