import 'package:flutter/material.dart';
import 'package:taski/app/app.dart';
import 'package:taski/core/config/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const App());
}
