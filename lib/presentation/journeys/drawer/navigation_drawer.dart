import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/routes_constants.dart';
import 'package:movie_app/presentation/blocs/login/login_cubit.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:movie_app/presentation/widgets/app_dialog.dart';
import 'package:wiredash/wiredash.dart';

import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/blocs/language/language_cubit.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

import 'navigation_expanded_list_item.dart';
import 'navigation_list_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.dimen_300.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.h,
              ),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(
              title: TranslationConstants.favoriteMovies.translate(context),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.favourite);
              },
            ),
            NavigationExpandedListItem(
              title: TranslationConstants.language.translate(context),
              children: Languages.languages.map((e) => e.value).toList(),
              onPressed: (index) {
                BlocProvider.of<LanguageCubit>(context).toogleLanguage(
                  Languages.languages[index],
                );
              },
            ),
            NavigationListItem(
              title: TranslationConstants.feedback.translate(context),
              onPressed: () {
                Navigator.of(context).pop();
                Wiredash.of(context)?.show();
              },
            ),
            NavigationListItem(
              title: TranslationConstants.about.translate(context),
              onPressed: () {
                Navigator.of(context).pop();
                _showDialog(context);
              },
            ),
            BlocListener<LoginCubit, LoginState>(
              listenWhen: (previous, current) => current is LogoutSuccess,
              listener: (context, state) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.initial, (route) => false);
              },
              child: NavigationListItem(
                title: TranslationConstants.logout.translate(context),
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).logout();
                },
              ),
            ),
            Spacer(),
            BlocBuilder<ThemeCubit, Themes>(
              builder: (context, theme) {
                return Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () => context.read<ThemeCubit>().toogleTheme(),
                    icon: Icon(
                      theme == Themes.dark
                          ? Icons.brightness_4_sharp
                          : Icons.brightness_7_sharp,
                      color:
                          theme == Themes.dark ? Colors.white : AppColor.vulcan,
                      size: Sizes.dimen_40.w,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: TranslationConstants.about,
        description: TranslationConstants.aboutDescription,
        buttonText: TranslationConstants.okay,
        image: Image.asset(
          'assets/pngs/tmdb_logo.png',
          height: Sizes.dimen_32.h,
        ),
      ),
    );
  }
}
