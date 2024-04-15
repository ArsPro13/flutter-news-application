import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchingRequestProvider extends ChangeNotifier {
  String request = 'popular';

  Future<void> updateSearch(String newRequest) async {
    request = newRequest;
    notifyListeners();
  }
}

final searchingProvider =
    ChangeNotifierProvider<SearchingRequestProvider>((ref) {
  return SearchingRequestProvider();
});
