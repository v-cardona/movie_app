import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';

import 'di/get_it.dart' as getIt;
import 'package:movie_app/presentation/movie_app.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // force to portrait mode only
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  // initialize dependency injection
  unawaited(getIt.init());
  runApp(MovieApp());
}