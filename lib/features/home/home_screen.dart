import 'package:flutter/material.dart';
import 'package:news_app/features/home/categories_view/categories_view.dart';
import 'package:news_app/features/home/home_drawer.dart';
import 'package:news_app/features/search_view/search_view.dart';
import 'package:news_app/features/sources_view/sources_view.dart';

import '../../data/model/articale_responce/Article.dart';
import '../../models/category.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget homeView;
  String appBarTitle = "Home";
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    homeView = CategoriesView(onCategoryClicked: onCategoryClicked);
  }

  void onArticlesLoaded(List<Article> newArticles) {
    articles = newArticles;
  }

  void onCategoryClicked(CategoryModel selectedCategory) {
    homeView = SourcesView(category: selectedCategory);
    appBarTitle = selectedCategory.name;
    setState(() {});
  }

  void onGoToHomeClicked() {
    homeView = CategoriesView(onCategoryClicked: onCategoryClicked);
    appBarTitle = "Home";
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchView()),
              );
            },
          ),
        ],
      ),
      drawer: HomeDrawer(onGoToHomeClicked: onGoToHomeClicked),
      body: homeView,
    );
  }
}
