import 'package:flutter/material.dart';
import 'package:webspark/feature/app/widget/material_context.dart';
import 'package:webspark/feature/initialization/model/dependencies.dart';
import 'package:webspark/feature/initialization/widget/dependencies_scope.dart';

class App extends StatelessWidget {
  const App({required this.result, super.key});

  final Dependencies result;

  @override
  Widget build(BuildContext context) => DependenciesScope(
        dependencies: result,
        child: const MaterialContext(),
      );
}
