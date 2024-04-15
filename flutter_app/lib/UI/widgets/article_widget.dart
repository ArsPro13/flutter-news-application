import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/article_image_widget.dart';

import '../../Data/models/article_model.dart';
import '../animations/transition.dart';
import 'article_like_button_widget.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({
    super.key,
    required this.article,
    required this.height,
    required this.width,
    required this.id,
  });

  final ArticleData article;
  final double height;
  final double width;
  final int id;

  @override
  ArticleWidgetState createState() => ArticleWidgetState();
}

class ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(verticalRoute(widget.article, widget.id));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 9,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ArticleImageWidget(
                  imageUrl: widget.article.urlToImage ?? patternUrl,
                  height: widget.height,
                  width: widget.width,
                  radius: 25,
                  id: widget.id,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: ArticleLikeButton(article: widget.article, id: widget.id),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 10),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      widget.article.title ?? "no title given",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}