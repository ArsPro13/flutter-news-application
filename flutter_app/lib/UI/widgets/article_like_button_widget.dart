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
  double target = 50;
  double current = 50;

  @override
  Widget build(BuildContext context) {
    var isLiked = false;

    final likedPosts = ref.watch(likedArticlesProvider).articles;

    for (var element in likedPosts) {
      if (element.url == widget.article.url) {
        isLiked = true;
        setState(() {
          current = 70;
          target = 70;
        });
      }
    }

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: current, end: target),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutBack,
      builder: (BuildContext context, double value, Widget? child) {
        return Padding(
          padding: EdgeInsets.all(40 - value / 2),
          child: IconButton(
            iconSize: value,
            icon: const Icon(Icons.favorite),
            color: isLiked ? Colors.redAccent : Colors.grey,
            onPressed: () {
              ref
                  .read(likedArticlesProvider.notifier)
                  .toggleLike(isLiked, widget.article);
              current = value;
              setState(() {
                target = target == 50 ? 70 : 50;
              });
            },
          ),
        );
      },
    );
  }
}
