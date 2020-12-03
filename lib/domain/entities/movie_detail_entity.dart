import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final int id;
  final String title, releaseDate, overview, posterPath, backdropPath;
  final num voteAverage;

  const MovieDetailEntity(
    this.id,
    this.title,
    this.releaseDate,
    this.overview,
    this.voteAverage,
    this.backdropPath,
    this.posterPath
  );

  @override
  List<Object> get props => [id];
}