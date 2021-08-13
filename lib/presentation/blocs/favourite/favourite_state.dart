part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteMoviesLoaded extends FavouriteState {
  final List<MovieEntity> movies;

  FavouriteMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class FavouriteMoviesError extends FavouriteState {}

class IsFavouriteMovie extends FavouriteState {
  final bool isFavourite;

  IsFavouriteMovie(this.isFavourite);

  @override
  List<Object> get props => [isFavourite];
}
