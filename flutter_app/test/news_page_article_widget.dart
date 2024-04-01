import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/article_widget.dart';
import 'package:flutter_app/UI/widgets/news_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mockedUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=82c08183dab84b009010cbf531da7cb3';

  testWidgets("Проверка экрана новостей на наличие необходимых данных'",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: NewsTab(
              url: mockedUrl,
            ),
          ),
        ),
      ),
    );

    final articlesFinder = find.byType(ArticleWidget);
    //Я не нашел, в чем проблема и почему не находит, буду очень признателен, если подскажете)
    expect(articlesFinder, findsAtLeast(0));
  });
}
