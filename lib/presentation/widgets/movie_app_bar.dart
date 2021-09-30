import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/screenutil/screenutil.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/journeys/search_movie/custom_search_movie_delegate.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'logo.dart';

class MovieAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/svgs/menu.svg',
              height: Sizes.dimen_12.h,
              color: context.read<ThemeCubit>().state == Themes.dark
                  ? Colors.white
                  : AppColor.vulcan,
            ),
          ),
          Expanded(child: Logo(height: Sizes.dimen_14)),
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  BlocProvider.of<SearchMovieCubit>(context),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              color: context.read<ThemeCubit>().state == Themes.dark
                  ? Colors.white
                  : AppColor.vulcan,
              size: Sizes.dimen_12.h,
            ),
          ),
        ],
      ),
    );
  }
}
