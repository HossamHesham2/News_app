import 'package:flutter/material.dart';
import 'package:news_app/data/model/articale_responce/Article.dart';
import '../data/api_service/api_service.dart';

class SearchProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<Article>? searchResults;

  Future<void> searchArticles(String query) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final results = await apiService.searchArticale(query);

      searchResults = results;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    searchResults = [];
    notifyListeners();
  }
}
