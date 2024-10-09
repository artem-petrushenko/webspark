import 'package:flutter/material.dart';
import 'package:webspark/core/route/route.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routing.onGenerateRoute,
      initialRoute: RoutePath.urlHandler,
    );
  }
}
