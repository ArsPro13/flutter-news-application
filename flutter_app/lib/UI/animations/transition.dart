import 'package:flutter/material.dart';
import 'package:flutter_app/Data/models/article_model.dart';
import 'package:flutter_app/UI/widgets/article_page_widget.dart';

// Route _createRoute(ArticleData givenArticle) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const ArticlePageWidget(article: givenArticle),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
