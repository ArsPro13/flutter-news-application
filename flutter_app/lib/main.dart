import 'package:flutter/material.dart';
import 'package:flutter_app/UI/components/article_widget.dart';
import 'package:flutter_app/UI/components/liked_articles_page_widget.dart';
import 'package:flutter_app/Data/models/article_model.dart';
import 'package:logger/logger.dart';
import 'package:flutter_app/UI/themes/dark_theme.dart';
import 'package:flutter_app/UI/themes/light_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Domain/liked-articles-logic.dart';
import 'UI/components/news_tab.dart';

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
    NewsTab(
        key: UniqueKey(),
        url:
            "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=82c08183dab84b009010cbf531da7cb3"),
    NewsTab(
        key: UniqueKey(),
        url:
            "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=82c08183dab84b009010cbf531da7cb3"),
    LikedArticlesPageWidget(),
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
                icon: Icon(Icons.computer),
                label: 'Technology',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Business',
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
        ));
  }
}


