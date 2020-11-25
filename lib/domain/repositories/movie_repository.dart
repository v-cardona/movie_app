import 'package:dartz/dartz.dart';

import 'package:movie_app/domain/entities/MovieEntity.dart';
import 'package:movie_app/domain/entities/app_error.dart';

abstract class MovieRepository {
  Future<Either<AppError, List<MovieEntity>>> getTrending();
}