import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/colors_manager/colors_manager.dart';
import '../../../data/model/articale_responce/Article.dart';
import '../../../providers/theme_provider.dart';

class FullArticlePage extends StatefulWidget {
  final Article article;

  const FullArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  State<FullArticlePage> createState() => _FullArticlePageState();
}

class _FullArticlePageState extends State<FullArticlePage> {

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.article.source!.name ?? "Article Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.article.title ?? "No Title",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 10.h),
            Text(
              widget.article.description ?? "",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text("By", style: Theme.of(context).textTheme.labelSmall),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    textStyle: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: Colors.blueAccent,
                  ),
                  child: Text(widget.article.author ?? "Unknown Author"),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              widget.article.publishedAt ?? "UnKnown Date",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.facebook),
                SizedBox(width: 22.w),
                FaIcon(FontAwesomeIcons.twitter),
                SizedBox(width: 22.w),
                FaIcon(FontAwesomeIcons.envelope),
                SizedBox(width: 22.w),
                FaIcon(FontAwesomeIcons.link),
              ],
            ),
            SizedBox(height: 20.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.article.urlToImage ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
              )
            ),
            SizedBox(height: 15.h),
            Divider(color: themeProvider.isDark ? ColorsManager.white : ColorsManager.black, thickness: 1.h),
            SizedBox(height: 15.h),
            Text(
              widget.article.content ?? "",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}
