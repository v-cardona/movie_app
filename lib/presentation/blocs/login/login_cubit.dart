import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/login_requets_params.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/login_user.dart';
import 'package:movie_app/domain/usecases/logout_user.dart';
import 'package:movie_app/presentation/blocs/loading/loading_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final LoadingCubit loadingCubit;

  LoginCubit({
    required this.loginUser,
    required this.logoutUser,
    required this.loadingCubit,
  }) : super(LoginInitial());

  void login(String username, String password) async {
    loadingCubit.show();
    final Either<AppError, bool> eitherResponse = await loginUser(
      LoginRequestParams(
        userName: username,
        password: password,
      ),
    );

    emit(
      eitherResponse.fold(
        (l) {
          var message = getErrorMessage(l.errorType);
          return LoginError(message);
        },
        (r) => LoginSuccess(),
      ),
    );
    loadingCubit.hide();
  }

  void loginGuest() async {
    emit(LoginSuccess());
  }

  void logout() async {
    await logoutUser(NoParams());
    emit(LogoutSuccess());
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
