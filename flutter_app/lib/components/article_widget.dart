import 'package:flutter/material.dart';

import '../models/article_model.dart';
import 'article_page_widget.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({Key? key, required this.article}) : super(key: key);

  final ArticleData article;

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
            padding:
                const EdgeInsets.only(left: 5, right: 5, bottom: 15, top: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.article.urlToImage ?? "no url given",
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Center(
                          child: Text(
                        'Image can not be reached',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 7, right: 7),
                  child: Text(widget.article.title ?? "no title given"),
                ),
              ],
            )));
  }
}
