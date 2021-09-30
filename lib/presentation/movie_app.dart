import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/routes_constants.dart';
import 'package:movie_app/common/screenutil/screenutil.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/blocs/language/language_cubit.dart';
import 'package:movie_app/presentation/blocs/loading/loading_cubit.dart';
import 'package:movie_app/presentation/blocs/login/login_cubit.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/journeys/loading/loading_screen.dart';
import 'package:movie_app/presentation/routes.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/presentation/wiredash_app.dart';

import 'fade_page_route_builder.dart';

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late LanguageCubit _languageCubit;
  late LoginCubit _loginCubit;
  late LoadingCubit _loadingCubit;
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();
    _themeCubit = getItInstance<ThemeCubit>();
    _themeCubit.loadPreferredTheme();
    _loginCubit = getItInstance<LoginCubit>();
    _loadingCubit = getItInstance<LoadingCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _languageCubit.close();
    _loginCubit.close();
    _loadingCubit.close();
    _themeCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil so that it can use it while defining
    ScreenUtil.init();

    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(
          value: _languageCubit,
        ),
        BlocProvider<LoginCubit>.value(
          value: _loginCubit,
        ),
        BlocProvider<LoadingCubit>.value(
          value: _loadingCubit,
        ),
        BlocProvider<ThemeCubit>.value(
          value: _themeCubit,
        ),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        builder: (context, theme) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              final ThemeData themeData = ThemeData();
              return WiredashApp(
                navigatorKey: _navigatorKey,
                languageCode: locale.languageCode,
                child: MaterialApp(
                  navigatorKey: _navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: 'Movie App',
                  theme: themeData.copyWith(
                    primaryColor:
                        theme == Themes.dark ? AppColor.vulcan : Colors.white,
                    scaffoldBackgroundColor:
                        theme == Themes.dark ? AppColor.vulcan : Colors.white,
                    brightness: theme == Themes.dark
                        ? Brightness.dark
                        : Brightness.light,
                    accentColor:
                        theme == Themes.dark ? AppColor.vulcan : Colors.white,
                    unselectedWidgetColor: AppColor.royalBlue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: theme == Themes.dark
                        ? ThemeText.getTextTheme()
                        : ThemeText.getLightTextTheme(),
                    appBarTheme: const AppBarTheme(
                      elevation: 0,
                    ),
                    cardTheme: CardTheme(
                      color:
                          theme == Themes.dark ? Colors.white : AppColor.vulcan,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      hintStyle: Theme.of(context).textTheme.greySubtitle1,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme == Themes.dark
                              ? Colors.white
                              : AppColor.vulcan,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  supportedLocales:
                      Languages.languages.map((e) => Locale(e.code)).toList(),
                  locale: locale,
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  builder: (context, child) {
                    return LoadingScreen(
                      screen: child!,
                    );
                  },
                  initialRoute: RouteList.initial,
                  onGenerateRoute: (RouteSettings settings) {
                    final routes = Routes.getRoutes(settings);
                    final WidgetBuilder? builder = routes[settings.name];
                    return FadePageRouteBuilder(
                      builder: builder!,
                      settings: settings,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
