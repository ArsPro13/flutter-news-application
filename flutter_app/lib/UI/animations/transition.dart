import 'package:flutter/material.dart';
import 'package:flutter_app/Data/models/article_model.dart';
import 'package:flutter_app/UI/widgets/article_page_widget.dart';

Route verticalRoute(ArticleData givenArticle, int given_id) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ArticlePageWidget(article: givenArticle, id: given_id,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0)).chain(CurveTween(curve: Curves.easeInOutExpo));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}