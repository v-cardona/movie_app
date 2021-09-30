import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class UpdateTheme extends UseCase<void, String> {
  final AppRepository appRepository;

  UpdateTheme(this.appRepository);

  @override
  Future<Either<AppError, void>> call(String theme) async {
    return await appRepository.updateTheme(theme);
  }
}
