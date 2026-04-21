import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/core/colors_manager/colors_manager.dart';
import 'package:news_app/data/model/articale_responce/Article.dart';
import 'package:news_app/features/articales/articale_item.dart';
import 'package:provider/provider.dart';

import '../../data/api_service/api_service.dart';
import '../../providers/theme_provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  List<Article> _results = [];
  bool _isLoading = false;
  String? _error;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() {
          _results = [];
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _error = null;
      });

      try {
        final articles = await apiService.searchArticale(query);
        setState(() {
          _results = articles ?? [];
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Search Articles")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔎 صندوق البحث
            TextField(
              controller: _controller,
              style: TextStyle(
                color: themeProvider.isDark ? ColorsManager.white : ColorsManager.black
                , // حسب الثيم
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: "Search here",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor ??
                    Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: ColorsManager.gray,
                    width: 1.5,
                  ),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(
                child: Text(
                  "Error: $_error",
                  style: const TextStyle(color: Colors.red),
                ),
              )
                  : _results.isEmpty
                  ? Center(
                child: Text("No Articale Avilable",style: TextStyle(
                  color: themeProvider.isDark ? ColorsManager.white : ColorsManager.black
                ),)
              )
                  : ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final article = _results[index];
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0),
                    child: ArticaleItem(articale: article),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
