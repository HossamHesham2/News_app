import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/colors_manager/colors_manager.dart';
import 'package:news_app/l10n/app_localizations.dart';
import '../../../models/category.dart';
import 'caregory_item.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({super.key, required this.onCategoryClicked});

  Function onCategoryClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.good_morning,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  onCategoryClicked(CategoryModel.categories[index]);
                },
                child: CaregoryItem(category: CategoryModel.categories[index]),
              ),
              itemCount: CategoryModel.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
