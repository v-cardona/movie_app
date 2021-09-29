import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/check_if_favourite_movie.dart';
import 'package:movie_app/domain/usecases/get_favourites_movies.dart';
import 'package:movie_app/domain/usecases/delete_favourite_movie.dart';
import 'package:movie_app/domain/usecases/save_movie.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final SaveMovie saveMovie;
  final GetFavouritesMovies getFavouritesMovies;
  final DeleteFavouriteMovie deleteFavouriteMovie;
  final CheckIfFavouriteMovie checkIfFavouriteMovie;

  FavouriteCubit({
    required this.saveMovie,
    required this.getFavouritesMovies,
    required this.deleteFavouriteMovie,
    required this.checkIfFavouriteMovie,
  }) : super(FavouriteInitial());

  void toogleFavouriteMovie(MovieEntity movie, bool isFavourite) async {
    if (isFavourite) {
      await deleteFavouriteMovie(MovieParams(movie.id));
    } else {
      await saveMovie(movie);
    }
    final response = await checkIfFavouriteMovie(
      MovieParams(movie.id),
    );
    emit(
      response.fold(
        (l) => FavouriteMoviesError(),
        (r) => IsFavouriteMovie(r),
      ),
    );
  }

  void loadFavouriteMovies() async {
    final response = await getFavouritesMovies(NoParams());
    emit(
      response.fold(
        (l) => FavouriteMoviesError(),
        (r) => FavouriteMoviesLoaded(r),
      ),
    );
  }

  void deleteMovie(int movieId) async {
    await deleteFavouriteMovie(MovieParams(movieId));
    loadFavouriteMovies();
  }

  void isFavouriteMovie(int movieId) async {
    final response = await checkIfFavouriteMovie(
      MovieParams(movieId),
    );
    emit(
      response.fold(
        (l) => FavouriteMoviesError(),
        (r) => IsFavouriteMovie(r),
      ),
    );
  }
}
