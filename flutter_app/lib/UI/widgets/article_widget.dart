import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/article_image_widget.dart';

import '../../Data/models/article_model.dart';
import 'article_like_button_widget.dart';
import 'article_page_widget.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget(
      {super.key,
      required this.article,
      required this.height,
      required this.width});

  final ArticleData article;
  final double height;
  final double width;

  @override
  ArticleWidgetState createState() => ArticleWidgetState();
}

class ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticlePageWidget(article: widget.article);
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 9,
              offset: const Offset(0, 0), // Shadow position
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
                    width: widget.width),
                Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    border: Border.all(),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.background.withOpacity(0),
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.05),
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.3),
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.7),
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.85),
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 20,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 7, right: 7),
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
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: ArticleLikeButton(article: widget.article),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
