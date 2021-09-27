import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/entities/app_error.dart';

import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/presentation/blocs/loading/loading_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropCubit movieBackdropCubit;
  final LoadingCubit loadingCubit;

  MovieCarouselBloc({
    @required this.getTrending,
    @required this.movieBackdropCubit,
    @required this.loadingCubit,
  }) : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
    if (event is CarouselLoadEvent) {
      loadingCubit.show();
      final moviesEither = await getTrending(NoParams());

      yield moviesEither.fold(
        (l) => MovieCarouselError(l.errorType),
        (movies) {
          movieBackdropCubit.backdropChanged(movies[event.defaultIndex]);
          return MovieCarouselLoaded(
            movies: movies,
            defaultIndex: event.defaultIndex,
          );
        },
      );
      loadingCubit.hide();
    }
  }
}
