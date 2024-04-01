import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Data/models/article_model.dart';
import '../../Domain/liked-articles-logic.dart';

class ArticleLikeButton extends ConsumerStatefulWidget {
  const ArticleLikeButton({
    super.key,
    required this.article,
  });

  final ArticleData article;

  @override
  ConsumerState<ArticleLikeButton> createState() => ArticleLikeButtonState();
}

class ArticleLikeButtonState extends ConsumerState<ArticleLikeButton> {
  @override
  Widget build(BuildContext context) {
    final likedPosts = ref.watch(likedArticlesProvider).articles;

    var isLiked = false;

    for (var element in likedPosts) {
      if (element.url == widget.article.url) {
        isLiked = true;
      }
    }

    return IconButton(
      iconSize: 40,
      icon: const Icon(Icons.favorite),
      color: isLiked ? Colors.redAccent : Colors.grey,
      onPressed: () => ref
          .read(likedArticlesProvider.notifier)
          .toggleLike(isLiked, widget.article),
    );
  }
}
