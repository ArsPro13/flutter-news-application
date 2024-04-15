import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/liked_articles_page_widget.dart';
import 'package:logger/logger.dart';
import 'package:flutter_app/UI/themes/dark_theme.dart';
import 'package:flutter_app/UI/themes/light_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Domain/liked-articles-logic.dart';
import 'UI/widgets/articles_list_widget.dart';
import 'UI/widgets/search_articles_list_widget.dart';

var logger = Logger();

void main() => runApp(const ProviderScope(child: NewsApp()));

class NewsApp extends ConsumerStatefulWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  NewsAppState createState() => NewsAppState();
}

class NewsAppState extends ConsumerState<NewsApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(likedArticlesProvider.notifier).fetchOldLikes();
  }

  final List<Widget> pages = <Widget>[
    SearchArticlesList(
      key: UniqueKey(),
    ),
    ArticlesList(
      key: UniqueKey(),
      url:
          "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=82c08183dab84b009010cbf531da7cb3",
    ),
    const LikedArticlesPageWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_android),
              label: 'Technology',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: _onItemTapped,
        ),
        body: pages[_selectedIndex],
      ),
    );
  }
}
