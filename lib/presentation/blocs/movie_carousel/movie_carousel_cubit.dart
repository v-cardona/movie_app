import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';

import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/presentation/blocs/loading/loading_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';

part 'movie_carousel_state.dart';

class MovieCarouselCubit extends Cubit<MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropCubit movieBackdropCubit;
  final LoadingCubit loadingCubit;

  MovieCarouselCubit({
    required this.getTrending,
    required this.movieBackdropCubit,
    required this.loadingCubit,
  }) : super(MovieCarouselInitial());

  void loadCarousel({int movieIndex = 0}) async {
    loadingCubit.show();
    final moviesEither = await getTrending(NoParams());

    emit(
      moviesEither.fold(
        (l) => MovieCarouselError(l.errorType),
        (movies) {
          movieBackdropCubit.backdropChanged(movies[movieIndex]);
          return MovieCarouselLoaded(
            movies: movies,
            defaultIndex: movieIndex,
          );
        },
      ),
    );
    loadingCubit.hide();
  }
}
