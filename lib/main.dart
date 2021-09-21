import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/data/tables/movie_table.dart';
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
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieTableAdapter());
  // initialize dependency injection
  unawaited(getIt.init());
  runApp(MovieApp());
}
