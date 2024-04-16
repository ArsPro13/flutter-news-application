import 'dart:convert';

import '../models/article_model.dart';
import 'articles_dao.dart';
import 'package:http/http.dart' as http;

class ArticlesRuntimeDao implements ArticlesDao {
  List<ArticleData> _articles = [];

  @override
  Future<List<ArticleData>> fetchArticlesByUrl(url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        final articles =
        (data['articles'] as List).map((i) => ArticleData.fromJson(i));
        _articles = articles.toList();
        return articles.toList();
      } else {
        _articles = [];
        return [];
      }
    } catch (err) {
      _articles = [];
      return [];
    }
  }

  @override
  List<ArticleData> getArticles() {
    return _articles;
  }
}
