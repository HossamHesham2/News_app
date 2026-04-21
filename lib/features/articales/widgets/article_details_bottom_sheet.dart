import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/colors_manager/colors_manager.dart';
import '../../../providers/theme_provider.dart';

class ArticleDetailsBottomSheet extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onViewFullArticle;

  const ArticleDetailsBottomSheet({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onViewFullArticle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: REdgeInsets.all(20),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: themeProvider.isDark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 220.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onViewFullArticle,
            style: Theme.of(context).elevatedButtonTheme.style,
            child: Text(
              "View Full Article",
            ),
          ),
        ],
      ),
    );
  }
}
