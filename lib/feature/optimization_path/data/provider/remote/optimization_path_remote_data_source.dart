import 'package:webspark/feature/optimization_path/data/dto/response_dto.dart';
import 'package:webspark/feature/optimization_path/data/dto/result_dto.dart';
import 'package:webspark/feature/optimization_path/data/dto/send_result_response.dart';

abstract interface class OptimizationPathRemoteDataSource {
  Future<ResponseDto> fetchTasks(
    String url,
  );

  Future<SendResultResponse> sendResults({
    required final List<ResultDto> results,
  });
}
