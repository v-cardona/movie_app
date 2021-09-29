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

  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();
    _loginCubit = getItInstance<LoginCubit>();
    _loadingCubit = getItInstance<LoadingCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _languageCubit.close();
    _loginCubit.close();
    _loadingCubit.close();
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
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          final ThemeData theme = ThemeData();
          return WiredashApp(
            navigatorKey: _navigatorKey,
            languageCode: locale.languageCode,
            child: MaterialApp(
              navigatorKey: _navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Movie App',
              theme: theme.copyWith(
                primaryColor: AppColor.vulcan,
                scaffoldBackgroundColor: AppColor.vulcan,
                accentColor: AppColor.royalBlue,
                unselectedWidgetColor: AppColor.royalBlue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: ThemeText.getTextTheme(),
                appBarTheme: const AppBarTheme(
                  elevation: 0,
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
      ),
    );
  }
}
