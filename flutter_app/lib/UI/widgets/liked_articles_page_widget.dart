import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Data/models/article_model.dart';
import 'package:flutter/material.dart';
import '../../Domain/liked-articles-logic.dart';
import 'article_widget.dart';

class LikedArticlesPageWidget extends ConsumerWidget {
  const LikedArticlesPageWidget({super.key});

  void initState() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ArticleData> articlesCollection =
        ref.watch(likedArticlesProvider).articles;
    return Center(
      child: ListView.builder(
        itemCount: articlesCollection.length,
        itemBuilder: (context, index) {
          return ArticleWidget(
              article:
                  articlesCollection[articlesCollection.length - index - 1],
              height: 300,
              width: 900,
              id: index,
          );
          return null;
        },
      ),
    );
  }
}
