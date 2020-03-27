import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/details/details.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreenNew extends StatelessWidget {
  final int id;
  DetailScreenNew({this.id});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state){
          if (state is DetailsStateLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is DetailsStateError) {
            return Text(state.error);
          }
          if(state is DetailsStateSuccess) {
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

/*
RaisedButton(
                  child: Text('push to New Screen'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context){
                        BlocProvider.of<DetailsBloc>(context).add(GetDetails(id: 554));
                        return DetailScreenNew();
                      }
                    ));
                  },
                ),
 */