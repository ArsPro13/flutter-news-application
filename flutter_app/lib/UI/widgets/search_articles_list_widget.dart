import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/Data/DAO/articles_dao.dart';
import 'package:flutter_app/Data/DAO/articles_runtime_dao.dart';
import 'package:flutter_app/Domain/searching_articles_logic.dart';
import 'package:flutter_app/UI/widgets/search_header_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'article_widget.dart';

class SearchArticlesList extends ConsumerStatefulWidget {
  const SearchArticlesList({
    super.key,
  });

  @override
  ConsumerState<SearchArticlesList> createState() => SearchArticlesListState();
}

class SearchArticlesListState extends ConsumerState<SearchArticlesList> {
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

  String getUrlByRequest(String request) {
    return 'https://newsapi.org/v2/everything?q=$request&apiKey=82c08183dab84b009010cbf531da7cb3';
  }

  @override
  void initState() {
    loaded = false;
    super.initState();
    currentURL = 'fortnite';
    fetchArticles(getUrlByRequest(currentURL), articlesData);
  }

  @override
  Widget build(BuildContext context) {
    final newURL = ref.watch(searchingProvider).request;
    if (newURL != currentURL) {
      currentURL = newURL;
      fetchArticles(getUrlByRequest(currentURL), articlesData);
    }
    return loaded
        ? RefreshIndicator.adaptive(
            onRefresh: () =>
                fetchArticles(getUrlByRequest(currentURL), articlesData),
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
                  SliverPersistentHeader(
                    pinned: false,
                    delegate: SearchHeaderWidget(
                      minExtent: 50,
                      maxExtent: 150,
                    ),
                  ),
                  SliverList.builder(
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
                ],
              ),
            ),
          )
        : Center(
            child: LoadingAnimationWidget.dotsTriangle(
                color: Theme.of(context).colorScheme.secondary, size: 100),
          );
  }
}
