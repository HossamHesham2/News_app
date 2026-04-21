import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/articales/articale_item.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/providers/articales_provider.dart';
import 'package:news_app/providers/sources_provider.dart';
import 'package:provider/provider.dart';
import '../../core/colors_manager/colors_manager.dart';

class SourcesView extends StatefulWidget {
  SourcesView({super.key, required this.category});

  CategoryModel category;

  @override
  State<SourcesView> createState() => _SourcesViewState();
}

class _SourcesViewState extends State<SourcesView> {
  late SourcesProvider sourcesProvider;
  late ArticalsProvider articalsProvider;

  void fetchData()async{
    await sourcesProvider.fetchSources(widget.category);
    articalsProvider.fetchArticales(sourcesProvider.sources[0]);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sourcesProvider = SourcesProvider();
    articalsProvider = ArticalsProvider();
    fetchData();

  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: sourcesProvider),
        ChangeNotifierProvider.value(value: articalsProvider),
      ],
      child: Column(
        children: [
          Consumer<SourcesProvider>(
            builder: (context, sourcesProvider, child) {
              if (sourcesProvider.isLoading){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (sourcesProvider.sources.isEmpty){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text("No Sources Found")),
                );
              }
              return DefaultTabController(
                length: sourcesProvider.sources.length,
                child: TabBar(
                  onTap: (index) {
                    articalsProvider.fetchArticales(sourcesProvider.sources[index]);
                  },
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: ColorsManager.white,
                  unselectedLabelStyle: Theme.of(context).textTheme.displaySmall,
                  dividerColor: Colors.transparent,
                  labelStyle:Theme.of(context).textTheme.displayMedium,
                  tabs: sourcesProvider.sources
                      .map((sources) => Tab(text: sources.name))
                      .toList(),
                ),
              );
            },
          ),
          Consumer<ArticalsProvider>(
            builder: (context, articalsProvider, child) {
              if (articalsProvider.isLoading){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (articalsProvider.articales.isEmpty){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text("No Articles Found")),
                );
              }
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: articalsProvider.articales.length,
                  itemBuilder: (context, index) =>
                      ArticaleItem(articale: articalsProvider.articales[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
