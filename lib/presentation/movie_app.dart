import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/routes_constants.dart';
import 'package:movie_app/common/screenutil/screenutil.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/blocs/loading/loading_bloc.dart';
import 'package:movie_app/presentation/blocs/login/login_bloc.dart';
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
  LanguageBloc _languageBloc;
  LoginBloc _loginBloc;
  LoadingBloc _loadingBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _languageBloc.add(LoadPreferredLanguageEvent());
    _loginBloc = getItInstance<LoginBloc>();
    _loadingBloc = getItInstance<LoadingBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _languageBloc.close();
    _loginBloc.close();
    _loadingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil so that it can use it while defining
    ScreenUtil.init();

    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(
          value: _languageBloc,
        ),
        BlocProvider<LoginBloc>.value(
          value: _loginBloc,
        ),
        BlocProvider<LoadingBloc>.value(
          value: _loadingBloc,
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return WiredashApp(
              navigatorKey: _navigatorKey,
              languageCode: state.locale.languageCode,
              child: MaterialApp(
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Movie App',
                theme: ThemeData(
                  primaryColor: AppColor.vulcan,
                  accentColor: AppColor.royalBlue,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  unselectedWidgetColor: AppColor.royalBlue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: const AppBarTheme(elevation: 0),
                ),
                supportedLocales:
                    Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                builder: (context, child) {
                  return LoadingScreen(
                    screen: child,
                  );
                },
                initialRoute: RouteList.initial,
                onGenerateRoute: (RouteSettings settings) {
                  final routes = Routes.getRoutes(settings);
                  final WidgetBuilder builder = routes[settings.name];
                  return FadePageRouteBuilder(
                    builder: builder,
                    settings: settings,
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
