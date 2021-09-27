import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/repositories/authentication_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class LogoutUser extends UseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  LogoutUser(this.authenticationRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    return await authenticationRepository.logoutUser();
  }
}
