import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class GetPreferredTheme extends UseCase<String, NoParams> {
  final AppRepository appRepository;

  GetPreferredTheme(this.appRepository);

  @override
  Future<Either<AppError, String>> call(NoParams params) async {
    return await appRepository.getPreferredTheme();
  }
}
