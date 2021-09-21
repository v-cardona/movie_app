import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

part 'movie_table.g.dart';

@HiveType(typeId: 0)
class MovieTable extends MovieEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterPath;

  MovieTable({
    @required this.id,
    @required this.title,
    @required this.posterPath,
  }) : super(
          id: id,
          backdropPath: '',
          posterPath: posterPath,
          releaseDate: '',
          title: title,
          voteAverage: 0,
        );

  factory MovieTable.fromMovieEntity(MovieEntity movieEntity) {
    return MovieTable(
      id: movieEntity.id,
      title: movieEntity.title,
      posterPath: movieEntity.posterPath,
    );
  }
}
