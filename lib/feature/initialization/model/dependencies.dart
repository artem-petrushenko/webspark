import 'package:webspark/feature/optimization_path/data/repository/optimization_path_repository.dart';

base class Dependencies {
  const Dependencies({
    required this.optimizationPathRepository,
  });

  final OptimizationPathRepository optimizationPathRepository;
}
