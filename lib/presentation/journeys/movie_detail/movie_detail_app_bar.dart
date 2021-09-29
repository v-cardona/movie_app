import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/blocs/favourite/favourite_bloc.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({
    Key? key,
    required this.movieDetailEntity,
  }) : super(key: key);

  final MovieDetailEntity movieDetailEntity;

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
            Icons.arrow_back,
            color: Colors.white,
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
                  color: Colors.white,
                  size: Sizes.dimen_12.h,
                ),
              );
            } else {
              return Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: Sizes.dimen_12.h,
              );
            }
          },
        )
      ],
    );
  }
}
