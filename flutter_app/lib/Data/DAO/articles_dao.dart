import '../models/article_model.dart';

abstract interface class ArticlesDao {
  Future<List<ArticleData>> fetchArticlesByUrl(String url);
  List<ArticleData> getArticles();
}