import 'package:flutter/material.dart';

import 'package:movie_app/common/screenutil/screenutil.dart';
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
        //3
        primaryColor: AppColor.vulcan,
        scaffoldBackgroundColor: AppColor.vulcan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      //4
      home: HomeScreen(),
    );
  }
}