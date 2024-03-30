import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker/app.dart';
import 'package:steps_tracker/firebase_options.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';

Future<void> main() async {
  /// Init the widgets
  WidgetsFlutterBinding.ensureInitialized();

  /// Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Init Injection
  await configure();

  runApp(const App());
}
