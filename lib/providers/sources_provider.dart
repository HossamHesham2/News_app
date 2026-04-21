import 'package:flutter/material.dart';
import 'package:news_app/data/api_service/api_service.dart';
import 'package:news_app/models/category.dart';

import '../data/model/sources_responce/Source.dart';

class SourcesProvider extends ChangeNotifier{
  List<Source> sources = [];
  bool isLoading = true;
  Future<void> fetchSources(CategoryModel category)async{
    isLoading = true;
    notifyListeners();
    sources =await apiService.getSources(category) ?? [];
    isLoading = false;
    notifyListeners();
  }
}