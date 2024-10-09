import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webspark/feature/app/widget/app.dart';
import 'package:webspark/feature/initialization/logic/composition_root.dart';
import 'package:webspark/feature/initialization/widget/initialization_failed_app.dart';

final class AppRunner {
  const AppRunner();

  Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (error) => log('FlutterError: $error');

    const initializationProcessor = CompositionRoot();

    try {
      final result = await initializationProcessor.compose();
      runApp(App(result: result));
    } catch (_, __) {
      log('Initialization failed');
      runApp(const InitializationFailedApp());
    }
  }
}
