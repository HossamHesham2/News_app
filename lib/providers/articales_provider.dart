import 'package:flutter/cupertino.dart';
import 'package:news_app/data/api_service/api_service.dart';
import 'package:news_app/data/model/articale_responce/Article.dart';
import 'package:news_app/data/model/sources_responce/Source.dart';

class ArticalsProvider extends ChangeNotifier{
  List<Article> articales = [];
  bool isLoading = true;

  void fetchArticales(Source source)async{
    isLoading = true;
    notifyListeners();
    articales = await apiService.getArticale(source) ?? [];
    isLoading = false;
    notifyListeners();
  }
}