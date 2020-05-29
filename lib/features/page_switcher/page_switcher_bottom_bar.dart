import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/features/catalog_page/presentation/pages/catalog_page.dart';
import 'package:flutter_infinite_list/features/favorite_page/presentation/pages/favorite_page.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/pages/search_page.dart';
import 'package:flutter_infinite_list/features/search_page/presentation/bloc/bloc.dart';
import 'package:flutter_infinite_list/features/page_switcher/page_switcher_navigate.dart';
import 'package:flutter_infinite_list/injection_container.dart' as di;


class PageSwitcher extends StatefulWidget {
  @override
  PageSwitcherState createState() => PageSwitcherState();
}

class PageSwitcherState extends State<PageSwitcher> {
  int _selectedIndex = 0;
  final List<NavigateTo> _listPages = <NavigateTo>[
    NavigateTo(child: CatalogPage()),
    NavigateTo(child: FavoritePage()),
    NavigateTo(
      child: BlocProvider<SearchPageBloc>(
        create: (context) => di.sl<SearchPageBloc>(),
        child: SearchPage(),
      ),
    ),
  ];

  void _onItemTapped(index) {
    if (_selectedIndex == index) {
      if (Navigator.of(_listPages[index].tabContext).canPop()) {
        Navigator.of(_listPages[index].tabContext)
            .popUntil((Route<dynamic> r) => r.isFirst);
      }
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _listPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            title: Text('Favorite'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        selectedFontSize: 12.0,
      ),
    );
  }
}