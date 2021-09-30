import 'package:movie_app/data/data_sources/language_local_data_source.dart';
import 'package:movie_app/data/data_sources/theme_local_data_source.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final LanguageLocalDataSource languageLocalDataSource;
  final ThemeLocalDataSource themeLocalDataSource;

  AppRepositoryImpl(this.languageLocalDataSource, this.themeLocalDataSource);

  @override
  Future<Either<AppError, String>> getPreferredLanguage() async {
    try {
      final response = await languageLocalDataSource.getPreferredLanguage();
      return Right(response);
    } on Exception {
      return Left(
        AppError(
          AppErrorType.database,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(String language) async {
    try {
      final response = await languageLocalDataSource.updateLanguage(language);
      return Right(response);
    } on Exception {
      return Left(
        AppError(
          AppErrorType.database,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, String>> getPreferredTheme() async {
    try {
      final response = await themeLocalDataSource.getPreferredTheme();
      return Right(response);
    } on Exception {
      return Left(
        AppError(
          AppErrorType.database,
        ),
      );
    }
  }

  @override
  Future<Either<AppError, void>> updateTheme(String theme) async {
    try {
      final response = await themeLocalDataSource.updateTheme(theme);
      return Right(response);
    } on Exception {
      return Left(
        AppError(
          AppErrorType.database,
        ),
      );
    }
  }
}
