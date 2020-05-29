import 'package:flutter/material.dart';

class NavigateTo extends StatelessWidget {
  BuildContext tabContext;
  final Widget child;
  NavigateTo({this.child});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              tabContext = context;
              return child;
            }
        );
      },
    );
  }
}