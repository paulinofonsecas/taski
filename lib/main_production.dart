import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taski/app/app.dart';
import 'package:taski/core/config/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    Builder(
      builder: (context) {
        if (kIsWeb) {
          return DevicePreview(
            builder: (context) => const App(),
          );
        }
        return const App();
      },
    ),
  );
}
