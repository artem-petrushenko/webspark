import 'package:webspark/feature/optimization_path/data/dto/response_dto.dart';
import 'package:webspark/feature/optimization_path/data/dto/result_dto.dart';
import 'package:webspark/feature/optimization_path/data/dto/send_result_response.dart';
import 'package:webspark/feature/optimization_path/data/provider/local/optimization_path_local_data_source.dart';
import 'package:webspark/feature/optimization_path/data/provider/remote/optimization_path_remote_data_source.dart';
import 'package:webspark/feature/optimization_path/data/repository/optimization_path_repository.dart';

final class OptimizationPathRepositoryImpl
    implements OptimizationPathRepository {
  const OptimizationPathRepositoryImpl({
    required OptimizationPathRemoteDataSource remoteDataSource,
    required OptimizationPathLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final OptimizationPathRemoteDataSource _remoteDataSource;
  final OptimizationPathLocalDataSource _localDataSource;

  @override
  Future<ResponseDto> fetchTasks(
    String url,
  ) async {
    return _remoteDataSource.fetchTasks(url);
  }

  @override
  Future<void> addOptimizationPath({required ResultDto result}) {
    return _localDataSource.addOptimizationPath(result: result);
  }

  @override
  Future<ResultDto> fetchOptimizationPath({required String id}) {
    return _localDataSource.fetchOptimizationPath(id: id);
  }

  @override
  Future<List<ResultDto>> fetchOptimizationPaths() {
    return _localDataSource.fetchOptimizationPaths();
  }

  @override
  Future<SendResultResponse> sendResults({required List<ResultDto> results}) {
    return _remoteDataSource.sendResults(results: results);
  }
}
