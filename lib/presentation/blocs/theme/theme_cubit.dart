import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_preferred_theme.dart';
import 'package:movie_app/domain/usecases/update_theme.dart';

enum Themes { light, dark }

class ThemeCubit extends Cubit<Themes> {
  final GetPreferredTheme getPreferredTheme;
  final UpdateTheme updateTheme;

  ThemeCubit({
    required this.getPreferredTheme,
    required this.updateTheme,
  }) : super(Themes.dark);

  Future<void> toogleTheme() async {
    await updateTheme(state == Themes.dark ? 'light' : 'dark');
    loadPreferredTheme();
  }

  void loadPreferredTheme() async {
    final response = await getPreferredTheme(NoParams());
    emit(response.fold(
      (l) => Themes.dark,
      (r) => r == 'dark' ? Themes.dark : Themes.light,
    ));
  }
}