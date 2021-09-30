import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';

abstract class ThemeLocalDataSource {
  Future<void> updateTheme(String theme);
  Future<String> getPreferredTheme();
}

class ThemeLocalDataSourceImpl extends ThemeLocalDataSource {
  @override
  Future<String> getPreferredTheme() async {
    final themeBox = await Hive.openBox('themeBox');
    return themeBox.get(
      'preferred_theme',
      defaultValue: 'dark',
    );
  }

  @override
  Future<void> updateTheme(String theme) async {
    final themeBox = await Hive.openBox('themeBox');
    unawaited(themeBox.put('preferred_theme', theme));
  }
}
