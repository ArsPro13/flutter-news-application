import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Data/models/article_model.dart';
import 'package:flutter/material.dart';
import '../../Domain/liked_articles_logic.dart';
import 'article_widget.dart';

class LikedArticlesPageWidget extends ConsumerStatefulWidget {
  const LikedArticlesPageWidget({super.key});

  @override
  ConsumerState<LikedArticlesPageWidget> createState() =>
      LikedArticlesPageWidgetState();
}

class LikedArticlesPageWidgetState
    extends ConsumerState<LikedArticlesPageWidget> {
  int currentlyLoaded = 5;

  void initState() {
    super.initState();
  }

  void loadMore(maximal) {
    setState(() {
      currentlyLoaded = min(currentlyLoaded + 5, maximal);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ArticleData> articlesCollection =
        ref.watch(likedArticlesProvider).articles;
    currentlyLoaded = min(currentlyLoaded, articlesCollection.length);
    return Center(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            loadMore(articlesCollection.length);
          }
          return false;
        },
        child: articlesCollection.length > 0
            ? CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 50),
                    sliver: SliverList.builder(
                      itemCount: min(
                          currentlyLoaded + 1, articlesCollection.length + 1),
                      itemBuilder: (context, index) {
                        if (index < currentlyLoaded) {
                          return ArticleWidget(
                            article: articlesCollection[index],
                            height: 300,
                            width: 1000,
                            id: index,
                          );
                        } else if (index < articlesCollection.length) {
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
              )
            : const Center(
                child: Text('Like articles to display them on this screen'),
              ),
      ),
    );
  }
}
