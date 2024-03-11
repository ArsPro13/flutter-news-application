import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleData {
  late String? author;
  late String? title;
  late String? description;
  late String? url;
  late String? urlToImage;
  late String? publishedAt;
  late String? content;

  ArticleData({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleData.fromJson(Map<String, dynamic> json) =>
      _$ArticleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDataToJson(this);
}

// @JsonSerializable()
// class ArticlesCollection {
//   late List<ArticleData> articles;
//   late String status;
//   late String totalResults;
//
//   ArticlesCollection({
//     required this.status,
//     required this.articles,
//     required this.totalResults,
//   });

// Future<void> fetchArticles(url) async {
//   var resp = await http.get(Uri.parse(url));
//   var data = jsonDecode(resp.body);
//
//   if (data['status'] != 'ok') {
//     throw Exception();
//   }
//
//   // data['articles'].forEach((article) {
//   //   if (article['urlToImage'] != null) {
//   articles = ArticlesCollection.fromJson(data).articles;
//   //         author: article['author'] ?? "",
//   //         title: article['title'] ?? "",
//   //         description: article['description'] ?? "",
//   //         url: article['url'] ?? "",
//   //         urlToImage: article['urlToImage'] ?? "",
//   //         publishedAt: article['publishedAt'] ?? "",
//   //         content: article['content'] ?? ""));
//   //   }
//   // });
// }

//   factory ArticlesCollection.fromJson(Map<String, dynamic> json) =>
//       _$ArticlesCollectionFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ArticlesCollectionToJson(this);
// }
