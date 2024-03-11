import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_app/themes/dark_theme.dart';
import 'package:flutter_app/themes/light_theme.dart';

import 'components/news_tab.dart';

var logger = Logger();

void main() => runApp(const NewsApp());

class NewsApp extends StatefulWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  NewsAppState createState() => NewsAppState();
}

class NewsAppState extends State<NewsApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
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

    // const Center(
    //   child: Text('settings'),
    // )
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
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            onTap: _onItemTapped,
          ),
          body: pages[_selectedIndex],
        ));
  }
}
