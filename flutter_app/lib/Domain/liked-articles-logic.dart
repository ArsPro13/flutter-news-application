import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/models/article_model.dart';

class likedArticlesListProvider extends ChangeNotifier {
  var articles = <ArticleData>[];

  Future<void> addArticle(ArticleData article) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    articles.add(article);

    List<String> articlesJsons = [];

    for (ArticleData element in articles) {
      articlesJsons.add(json.encode(element.toJson()));
    }

    await prefs.setStringList('likedArticles', articlesJsons);

    notifyListeners();
  }

  Future<void> removeArticle(String articleUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    articles
        .remove(articles.firstWhere((element) => element.url == articleUrl));

    List<String> articlesJsons = [];

    for (ArticleData element in articles) {
      articlesJsons.add(json.encode(element.toJson()));
    }

    await prefs.setStringList('likedArticles', articlesJsons);

    notifyListeners();
  }

  Future<void> toggleLike(bool isLiked, ArticleData article) async {
    if (isLiked) {
      removeArticle(article.url ?? "");
    } else {
      addArticle(article);
    }
  }

  Future<void> fetchOldLikes() async {
    articles = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> data = prefs.getStringList('likedArticles') ?? [];

    for (var element in data) {
      addArticle(ArticleData.fromJson(json.decode(element)));
    }
  }
}

late final likedArticlesProvider =
    ChangeNotifierProvider<likedArticlesListProvider>((ref) {
  return likedArticlesListProvider();
});
