import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_infinite_list/features/detail_page/presentation/bloc/bloc.dart';


class DetailPage extends StatelessWidget {
  final int id;
  DetailPage({this.id});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state){
        if (state is DetailPageStateLoading) {
          return Center(
              child: CircularProgressIndicator()
          );
        }
        if (state is DetailPageStateError) {
          return Text(state.error);
        }
        if(state is DetailPageStateSuccess) {
          if (state.item.containsKey(id)) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(state.item[id].title),
                ),
                body: ListView(
                  children: <Widget>[
                    FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      height: 640,
                      width: 260,
                      placeholder: kTransparentImage,
                      image: state.item[id].posterUrl,
                    ),
                    Text(state.item[id].title),
                    Text(state.item[id].body),
                  ],
                )
            );
          }
        }
        return Text('');
      },
    );
  }
}