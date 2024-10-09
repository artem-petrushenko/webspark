import 'package:flutter/material.dart';

class InitializationFailedApp extends StatelessWidget {
  const InitializationFailedApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Scaffold(
          body: Text(
            'Initialization failed',
          ),
        ),
      );
}
