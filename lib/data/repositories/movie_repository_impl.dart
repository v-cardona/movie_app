import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app/data/data_sources/movie_local_data_source.dart';

import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/data/models/cast_crew_result_data_model.dart';
import 'package:movie_app/data/models/movie_detail_model.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/video_model.dart';
import 'package:movie_app/data/tables/movie_table.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
  );

  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async {
    try {
      List<MovieModel> movies = await remoteDataSource.getTrending();
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getComingSoon() async {
    try {
      List<MovieModel> movies = await remoteDataSource.getComingSoon();
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getPlayingNow() async {
    try {
      List<MovieModel> movies = await remoteDataSource.getPlayingNow();
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getPopular() async {
    try {
      List<MovieModel> movies = await remoteDataSource.getPopular();
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getCastCrew(int id) async {
    try {
      final castCrew = await remoteDataSource.getCastCrew(id);
      return Right(castCrew);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<VideoModel>>> getVideos(int id) async {
    try {
      final videos = await remoteDataSource.getVideos(id);
      return Right(videos);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getSearchedMovies(
      String searchTerm) async {
    try {
      final movies = await remoteDataSource.getSearchedMovies(searchTerm);
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfMovieFavourite(int movieId) async {
    try {
      final response = await localDataSource.checkIfMovieFavourite(movieId);
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavouriteMovie(int movieId) async {
    try {
      final response = await localDataSource.deleteMovie(movieId);
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavouritesMovies() async {
    try {
      final response = await localDataSource.getMovies();
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity) async {
    try {
      final response = await localDataSource
          .saveMovie(MovieTable.fromMovieEntity(movieEntity));
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
