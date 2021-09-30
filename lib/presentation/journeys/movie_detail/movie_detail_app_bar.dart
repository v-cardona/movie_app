import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/blocs/favourite/favourite_bloc.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/themes/app_color.dart';

class MovieDetailAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailAppBar({
    Key? key,
    required this.movieDetailEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: context.read<ThemeCubit>().state == Themes.dark
                ? Colors.white
                : AppColor.vulcan,
            size: Sizes.dimen_12.h,
          ),
        ),
        BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            if (state is IsFavouriteMovie) {
              return GestureDetector(
                onTap: () => BlocProvider.of<FavouriteCubit>(context)
                    .toogleFavouriteMovie(
                  MovieEntity.fromMovieDetailEntity(movieDetailEntity),
                  state.isFavourite,
                ),
                child: Icon(
                  state.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: context.read<ThemeCubit>().state == Themes.dark
                      ? Colors.white
                      : AppColor.vulcan,
                  size: Sizes.dimen_12.h,
                ),
              );
            } else {
              return Icon(
                Icons.favorite_border,
                color: context.read<ThemeCubit>().state == Themes.dark
                    ? Colors.white
                    : AppColor.vulcan,
                size: Sizes.dimen_12.h,
              );
            }
          },
        ),
      ],
    );
  }
}
