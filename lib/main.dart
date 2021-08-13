import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'di/get_it.dart' as getIt;
import 'package:movie_app/presentation/movie_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // force to portrait mode only
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  // get path document of app
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // initialize dependency injection
  unawaited(getIt.init());
  runApp(MovieApp());
}
