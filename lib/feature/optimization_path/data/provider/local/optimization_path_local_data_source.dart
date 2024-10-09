import 'package:webspark/feature/optimization_path/data/dto/result_dto.dart';

abstract interface class OptimizationPathLocalDataSource {
  Future<void> addOptimizationPath({
    required final ResultDto result,
  });

  Future<ResultDto> fetchOptimizationPath({
    required final String id,
  });

  Future<List<ResultDto>> fetchOptimizationPaths();
}
