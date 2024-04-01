import 'package:flutter/material.dart';
import 'package:flutter_app/Data/models/article_model.dart';
import 'package:flutter_app/UI/widgets/article_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ArticleData mockedArticle = ArticleData(
      author: 'author',
      title: 'title',
      description: 'decription',
      url: 'https://ya.ru/',
      urlToImage:
          'https://i.pinimg.com/736x/46/d2/c6/46d2c6afb9fe9a3bea39cee74c8db135.jpg',
      publishedAt: '2024-03-31T14:23:00Z',
      content: 'content');

  testWidgets("Проверка экрана новости на наличие необходимых данных'",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ArticlePageWidget(article: mockedArticle),
          ),
        ),
      ),
    );

    final titleFinder = find.text('title');
    expect(titleFinder, findsOneWidget);

    expect(
        find.image(const NetworkImage(
            'https://i.pinimg.com/736x/46/d2/c6/46d2c6afb9fe9a3bea39cee74c8db135.jpg')),
        findsOneWidget);

    final contentFinder = find.text('content');
    expect(contentFinder, findsOneWidget);

    final authorFinder = find.text('author at 14:23:00 on 2024-03-31');
    expect(authorFinder, findsOneWidget);
  });
}
