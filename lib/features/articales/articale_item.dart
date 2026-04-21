import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/articales/widgets/article_details_bottom_sheet.dart';
import 'package:news_app/features/articales/widgets/full_articale_page.dart';
import 'package:provider/provider.dart';
import '../../core/colors_manager/colors_manager.dart';
import '../../data/model/articale_responce/Article.dart';
import '../../providers/theme_provider.dart';
class ArticaleItem extends StatelessWidget {
  ArticaleItem({super.key, required this.articale});

  Article articale;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) =>
              ArticleDetailsBottomSheet(
            imageUrl: articale.urlToImage ?? "",
            title: articale.title ?? "No Title",
            onViewFullArticle: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullArticlePage(article: articale),
                ),
              );
            },
          ),
        );
      },
      child: Container(
        margin: REdgeInsets.symmetric(horizontal: 11.w),
        padding: REdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: themeProvider.isDark
                ? ColorsManager.white
                : ColorsManager.black,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: articale.urlToImage != null && articale.urlToImage!.isNotEmpty
                  ? Image.network(
                articale.urlToImage!,
                height: 220.h,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 220.h,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    height: 220.h,
                    child: const Center(
                      child: Text("No Image"),
                    ),
                  );
                },
              )
                  : SizedBox(
                height: 220.h,
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 60),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              articale.title ?? "No Title",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    articale.author ?? "UnKnown Author",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                Text(
                  articale.publishedAt ?? "UnKnown Date",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
