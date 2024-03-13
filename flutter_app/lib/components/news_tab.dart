import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../models/article_model.dart';
import 'article_widget.dart';
import 'package:http/http.dart' as http;

import 'package:json_annotation/json_annotation.dart';

class NewsTab extends StatefulWidget {
  final String url;

  const NewsTab({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  NewsTabState createState() => NewsTabState();
}

class NewsTabState extends State<NewsTab> {
  List<ArticleData> articlesCollection = [];
  bool loaded = true;
  int currentlyLoaded = 5;

  Future<List<ArticleData>> fetchArticlesByUrl(url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final articles =
          (data['articles'] as List).map((i) => ArticleData.fromJson(i));
      return articles.toList();
    } else {
      return [];
    }
  }

  Future<void> fetchArticles(url) async {
    setState(() {
      loaded = false;
    });

    articlesCollection = await fetchArticlesByUrl(url);

    setState(() {
      loaded = true;
    });
  }

  void loadMore(maximal) {
    setState(() {
      currentlyLoaded = min(currentlyLoaded + 5, maximal);
    });
  }

  @override
  void initState() {
    loaded = false;
    super.initState();
    fetchArticles(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? RefreshIndicator.adaptive(
            onRefresh: () => fetchArticles(widget.url),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.extentAfter == 0) {
                  loadMore(articlesCollection.length);
                }
                return false;
              },
              child: Center(
                child: ListView.builder(
                  itemCount: currentlyLoaded + 1,
                  itemBuilder: (context, index) {
                    if (index < currentlyLoaded) {
                      return ArticleWidget(article: articlesCollection[index], height: 300, width: 900);
                    } else if (index < articlesCollection.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),
          )
        : const Center(
            child: LoadingIndicator(
              indicatorType: Indicator.pacman,
              colors: [Colors.blueAccent, Colors.red],
              strokeWidth: 1,
            ),
          );
  }
}
