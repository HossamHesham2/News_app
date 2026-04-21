import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/colors_manager/colors_manager.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/models/category.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';

class CaregoryItem extends StatelessWidget {
  const CaregoryItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    String imageToShow = themeProvider.isDark && category.darkImagePath != null
        ? category.darkImagePath!
        : category.imagePath;

    return Container(
      decoration: BoxDecoration(
        border: themeProvider.isDark
            ? null
            : Border.all(color: ColorsManager.gray),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.gray,
              blurRadius: 8,      
              spreadRadius: 0,
              offset: Offset(0, 4)
          )
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(imageToShow),
          ),
          Positioned(
            bottom: 20,
            left: category.isRightAligned ? null : 20,
            right: category.isRightAligned ? 20 : null,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorsManager.gray,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!category.isRightAligned)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorsManager.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.view_all,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  if (category.isRightAligned)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorsManager.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
