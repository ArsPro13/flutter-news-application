import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/article_image_widget.dart';

import '../../Data/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'article_like_button_widget.dart';

class ArticlePageWidget extends StatefulWidget {
  const ArticlePageWidget({Key? key, required this.article, required this.id}) : super(key: key);

  final ArticleData article;
  final int id;

  @override
  ArticlePageWidgetState createState() => ArticlePageWidgetState();
}

class ArticlePageWidgetState extends State<ArticlePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Container(
              height: 600,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.background.withOpacity(0),
                ],
              )),
            ),
          ]),
          Positioned.fill(
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    tooltip: 'Return to the main page',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.article.title ?? "no title given",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                ArticleImageWidget(
                  imageUrl: widget.article.urlToImage ?? patternUrl,
                  height: 300,
                  width: 1000,
                  radius: 0,
                  id: widget.id,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                      widget.article.description ?? "no description given"),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(widget.article.content ?? "no content given"),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                      '${widget.article.author} at ${widget.article.publishedAt?.substring(11, 19)} on ${widget.article.publishedAt?.substring(0, 10)}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    child: const Text('Open article in browser'),
                    onTap: () => launchUrl(Uri.parse(widget.article.url ?? "")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: ArticleLikeButton(article: widget.article),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
