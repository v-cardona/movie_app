part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavouriteMovieEvent extends FavouriteEvent {
  @override
  List<Object> get props => [];
}

class DeleteFavouriteMovieEvent extends FavouriteEvent {
  final int movieId;

  DeleteFavouriteMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class ToggleFavouriteMovieEvent extends FavouriteEvent {
  final MovieEntity movieEntity;
  final bool isFavourite;

  ToggleFavouriteMovieEvent(this.movieEntity, this.isFavourite);

  @override
  List<Object> get props => [movieEntity, isFavourite];
}

class CheckIfFavouriteMovieEvent extends FavouriteEvent {
  final int movieId;

  CheckIfFavouriteMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
