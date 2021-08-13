import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class CheckIfFavouriteMovie extends UseCase<bool, MovieParams> {
  final MovieRepository movieRepository;

  CheckIfFavouriteMovie(this.movieRepository);

  @override
  Future<Either<AppError, bool>> call(MovieParams params) async {
    return await movieRepository.checkIfMovieFavourite(params.id);
  }
}
