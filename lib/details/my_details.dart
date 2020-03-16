import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/details/details.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreenNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state){
        if (state is DetailsStateLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is DetailsStateError) {
          return Text(state.error);
        }
        if(state is DetailsStateSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.item.title),
            ),
            body: ListView(
              children: <Widget>[
                FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    height: 640,
                    width: 260,
                    placeholder: kTransparentImage,
                    image: state.item.posterUrl,
                ),
                Text(state.item.title),
                Text(state.item.body),
              ],
            )
          );
        }
        return Text('');
      },
    );
  }
}
