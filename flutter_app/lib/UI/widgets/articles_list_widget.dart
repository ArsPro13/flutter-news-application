import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/Data/DAO/articles_dao.dart';
import 'package:flutter_app/Data/DAO/articles_runtime_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'article_widget.dart';

class ArticlesList extends ConsumerStatefulWidget {
  final String url;

  const ArticlesList({
    super.key,
    required this.url,
  });

  @override
  ConsumerState<ArticlesList> createState() => ArticlesListState();
}

class ArticlesListState extends ConsumerState<ArticlesList> {
  ArticlesDao articlesData = ArticlesRuntimeDao();
  bool loaded = true;
  int currentlyLoaded = 5;
  String currentURL = '';

  Future<void> fetchArticles(url, ArticlesDao dao) async {
    setState(() {
      loaded = false;
    });
    await dao.fetchArticlesByUrl(url);
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
    fetchArticles(widget.url, articlesData);
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? RefreshIndicator.adaptive(
            onRefresh: () => fetchArticles(widget.url, articlesData),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.extentAfter == 0) {
                  loadMore(articlesData.getArticles().length);
                }
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 50),
                    sliver: SliverList.builder(
                      itemCount: currentlyLoaded + 1,
                      itemBuilder: (context, index) {
                        if (index < currentlyLoaded) {
                          return ArticleWidget(
                            article: articlesData.getArticles()[index],
                            height: 300,
                            width: 1000,
                            id: index,
                          );
                        } else if (index < articlesData.getArticles().length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
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
