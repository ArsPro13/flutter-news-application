import 'package:flutter_app/Data/DAO/articles_dao.dart';
import 'package:flutter_app/Data/DAO/articles_runtime_dao.dart';
import 'package:flutter_test/flutter_test.dart';

// testing function ArticlesRuntimeDao.fetchArticlesByUrl

void main() {
  test('Проверка функции на невалидную ссылку', () async {
    ArticlesDao articlesData = ArticlesRuntimeDao();

    await articlesData.fetchArticlesByUrl('a.a');

    expect(articlesData.getArticles(), equals([]));
  });

  test('Проверка функции на наличие полученных данных', () async {
    ArticlesDao articlesData = ArticlesRuntimeDao();

    const url =
        'https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=82c08183dab84b009010cbf531da7cb3';

    await articlesData.fetchArticlesByUrl(url);

    expect(articlesData.getArticles().length, greaterThanOrEqualTo(1));
  });

  test('Проверка функции на соответствие полученных данных', () async {
    ArticlesDao articlesData = ArticlesRuntimeDao();

    const url =
        'https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=82c08183dab84b009010cbf531da7cb3';

    await articlesData.fetchArticlesByUrl(url);

    for (var item in articlesData.getArticles()) {
      expect(item.title?.length, greaterThanOrEqualTo(1));
      expect(item.url?.length, greaterThanOrEqualTo(1));
      expect(item.publishedAt?.length, greaterThanOrEqualTo(1));
    }
  });
}
