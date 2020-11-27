import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/common/constants/languages.dart';

import 'package:movie_app/common/screenutil/screenutil.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/journeys/home/home_screen.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

class MovieApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil so that it can use it while defining
    ScreenUtil.init();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primaryColor: AppColor.vulcan,
        accentColor: AppColor.royalBlue,
        scaffoldBackgroundColor: AppColor.vulcan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
      locale: Locale(Languages.languages[0].code),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: HomeScreen(),
    );
  }
}