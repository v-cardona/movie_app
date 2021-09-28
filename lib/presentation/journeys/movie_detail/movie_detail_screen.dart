import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/blocs/cast/cast_cubit.dart';
import 'package:movie_app/presentation/blocs/favourite/favourite_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie_app/presentation/blocs/videos/videos_cubit.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:movie_app/presentation/journeys/movie_detail/videos_widget.dart';

import 'big_poster.dart';
import 'cast_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({Key key, @required this.movieDetailArguments})
      : assert(movieDetailArguments != null, 'arguments must not be null'),
        super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailCubit _movieDetailCubit;
  CastCubit _castCubit;
  VideosCubit _videosCubit;
  FavouriteCubit _favouriteCubit;

  @override
  void initState() {
    super.initState();
    _movieDetailCubit = getItInstance<MovieDetailCubit>();
    _castCubit = _movieDetailCubit.castCubit;
    _videosCubit = _movieDetailCubit.videosCubit;
    _favouriteCubit = _movieDetailCubit.favouriteCubit;
    _movieDetailCubit.loadMovieDetail(
      widget.movieDetailArguments.movieId,
    );
  }

  @override
  void dispose() {
    _movieDetailCubit?.close();
    _castCubit?.close();
    _videosCubit?.close();
    _favouriteCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailCubit),
          BlocProvider.value(value: _castCubit),
          BlocProvider.value(value: _videosCubit),
          BlocProvider.value(value: _favouriteCubit)
        ],
        child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(movie: movieDetail),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16.w,
                          vertical: Sizes.dimen_8.h),
                      child: Text(
                        movieDetail.overview,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                      child: Text(
                        TranslationConstants.cast.translate(context),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CastWidget(),
                    VideosWidget(videosCubit: _videosCubit)
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Container();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
