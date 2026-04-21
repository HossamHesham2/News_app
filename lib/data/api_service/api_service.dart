import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/data/model/articale_responce/ArticalesResponce.dart';
import 'package:news_app/data/model/sources_responce/Source.dart';
import 'package:news_app/models/category.dart';
import '../model/articale_responce/Article.dart';
import '../model/sources_responce/SouecesResponce.dart';
///https://newsapi.org/v2/everything?q=bitcoin&apiKey=82807b36006d4025a961422f67d68b83
class apiService {
  static const String baseUrl = "newsapi.org";
  static const String sourcesEndPoint = "/v2/top-headlines/sources";
  static const String ArticaleEndPoint = "/v2/everything";
  static const String apiKey = "82807b36006d4025a961422f67d68b83";

  static Future<List<Source>?> getSources(CategoryModel category) async {
    Uri url = Uri.https(
        baseUrl,
        sourcesEndPoint, {
      "apiKey": apiKey,
      "category": category.id,
    });
    http.Response serverResponce = await http.get(url);

    var json = jsonDecode(serverResponce.body);

    SourcesResponce sourcesResponce = SourcesResponce.fromJson(json);
    return sourcesResponce.sources;
  }

  static Future<List<Article>?> getArticale(Source source) async{
    Uri url = Uri.https(
      baseUrl,
      ArticaleEndPoint,
      {
        "apiKey": apiKey,
        "sources": source.id,
      }
    );
    http.Response serverResponce =await http.get(url);

    var json = jsonDecode(serverResponce.body);

    ArticalesResponce articalesResponce = ArticalesResponce.fromJson(json);

    return articalesResponce.articles;

  }

  static Future<List<Article>?> searchArticale(String query) async {
    Uri url = Uri.https(
      baseUrl,
      ArticaleEndPoint,
      {
        "apiKey": apiKey,
        "q": query,
      },
    );

    http.Response serverResponce = await http.get(url);

    var json = jsonDecode(serverResponce.body);

    ArticalesResponce articalesResponce = ArticalesResponce.fromJson(json);

    return articalesResponce.articles;
  }

}
