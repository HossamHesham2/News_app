import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/colors_manager/colors_manager.dart';
import 'package:news_app/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../../core/routes_manager/Routes_manager.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key, required this.onGoToHomeClicked });
  Function onGoToHomeClicked;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 166.h,
            color: ColorsManager.white,
            child: Text(
              "News App",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                InkWell(
                  onTap: () {
                    onGoToHomeClicked();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.home_rounded, color: ColorsManager.white),
                      SizedBox(width: 4.w),
                      Text(
                        AppLocalizations.of(context)!.go_to_home,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Divider(color: ColorsManager.white, thickness: 1.h),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Icon(Icons.color_lens, color: ColorsManager.white),
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                SizedBox(height: 9.h),
                Row(
                  children: [
                    Text(
                      "Dark Mode",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Spacer(),
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, _) => Switch(
                        value: themeProvider.isDark,
                        onChanged: (isDark) {
                          themeProvider.ChangeAppTheme(
                            isDark ? ThemeMode.dark : ThemeMode.light,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Divider(color: ColorsManager.white, thickness: 1.h),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Icon(Icons.language, color: ColorsManager.white),
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                SizedBox(height: 9.h),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.english,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Consumer<LanguageProvider>(
                      builder: (context, languageProvider, _) => Switch(
                        value: languageProvider.isEnglish,
                        onChanged: (value) {
                          languageProvider.ChangeAppLanguage(
                            value ? "en" : "ar",
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
