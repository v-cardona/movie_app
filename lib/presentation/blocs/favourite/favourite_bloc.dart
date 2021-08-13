import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/check_if_favourite_movie.dart';
import 'package:movie_app/domain/usecases/get_favourites_movies.dart';
import 'package:movie_app/domain/usecases/delete_favourite_movie.dart';
import 'package:movie_app/domain/usecases/save_movie.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final SaveMovie saveMovie;
  final GetFavouritesMovies getFavouritesMovies;
  final DeleteFavouriteMovie deleteFavouriteMovie;
  final CheckIfFavouriteMovie checkIfFavouriteMovie;

  FavouriteBloc({
    @required this.saveMovie,
    @required this.getFavouritesMovies,
    @required this.deleteFavouriteMovie,
    @required this.checkIfFavouriteMovie,
  }) : super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    if (event is ToggleFavouriteMovieEvent) {
      bool isFavourite = event.isFavourite;
      if (isFavourite) {
        await deleteFavouriteMovie.call(MovieParams(event.movieEntity.id));
      } else {
        await saveMovie.call(event.movieEntity);
      }
      final response = await checkIfFavouriteMovie.call(
        MovieParams(event.movieEntity.id),
      );
      yield response.fold(
        (l) => FavouriteMoviesError(),
        (r) => IsFavouriteMovie(r),
      );
    } else if (event is LoadFavouriteMovieEvent) {
      _fetchLoadFavouriteMovies();
    } else if (event is DeleteFavouriteMovieEvent) {
      await deleteFavouriteMovie.call(MovieParams(event.movieId));
      _fetchLoadFavouriteMovies();
    } else if (event is CheckIfFavouriteMovieEvent) {
      final response = await checkIfFavouriteMovie.call(
        MovieParams(event.movieId),
      );
      yield response.fold(
        (l) => FavouriteMoviesError(),
        (r) => IsFavouriteMovie(r),
      );
    }
  }

  Stream<FavouriteState> _fetchLoadFavouriteMovies() async* {
    final response = await getFavouritesMovies.call(NoParams());
    yield response.fold(
      (l) => FavouriteMoviesError(),
      (r) => FavouriteMoviesLoaded(r),
    );
  }
}
