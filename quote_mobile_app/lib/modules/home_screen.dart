import 'package:flutter/material.dart';
import 'package:quote_mobile_app/modules/author_tab/authors_list_screen.dart';
import 'package:quote_mobile_app/modules/favourites_module/favourite_quote_screen.dart';
import 'package:quote_mobile_app/modules/search_tab/search_quote_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  final List<Widget> _tabs = [
    const AuthorsListScreen(),
    const SearchQuoteScreen(),
    const FavouriteQuoteScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Author',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourites',
          ),
        ],
        onTap: (int newIndex) {
          setState(() {
            _currentTabIndex = newIndex;
          });
        },
      ),
    );
  }
}
