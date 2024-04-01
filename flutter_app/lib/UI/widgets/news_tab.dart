import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/Data/models/article_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:http/http.dart' as http;

import 'article_widget.dart';

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
  List<ArticleData> data = [];
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

    data = await fetchArticlesByUrl(url);

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
                  loadMore(data.length);
                }
                return false;
              },
              child: Center(
                child: ListView.builder(
                  itemCount: currentlyLoaded + 1,
                  itemBuilder: (context, index) {
                    if (index < currentlyLoaded) {
                      return ArticleWidget(
                          article: data[index], height: 300, width: 900);
                    } else if (index < data.length) {
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
