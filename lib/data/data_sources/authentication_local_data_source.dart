import 'package:hive/hive.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String session);
}

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDataSource {
  @override
  Future<void> saveSessionId(String session) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.put('session_id', session);
  }
}
