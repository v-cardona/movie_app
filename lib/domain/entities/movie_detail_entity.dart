import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final int id;
  final String title;
  final String? releaseDate;
  final String? overview;
  final String posterPath;
  final String? backdropPath;
  final num? voteAverage;

  const MovieDetailEntity({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.voteAverage,
    required this.backdropPath,
    required this.posterPath,
  });

  @override
  List<Object> get props => [id];
}
