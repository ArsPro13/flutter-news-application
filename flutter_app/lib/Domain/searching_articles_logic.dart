import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/models/article_model.dart';

class SearchingRequestProvider extends ChangeNotifier {
  String request = 'popular';

  Future<void> updateSearch(String newRequest) async {
    request = newRequest;
    notifyListeners();
  }
}

late final searchingProvider =
ChangeNotifierProvider<SearchingRequestProvider>((ref) {
  return SearchingRequestProvider();
});
