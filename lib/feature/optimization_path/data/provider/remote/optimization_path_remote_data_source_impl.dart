import 'dart:convert';

import 'package:webspark/core/client/rest/rest_client.dart';
import 'package:webspark/feature/optimization_path/data/dto/response_dto.dart';
import 'package:webspark/feature/optimization_path/data/dto/result_dto.dart';
import 'package:webspark/feature/optimization_path/data/dto/send_result_response.dart';
import 'package:webspark/feature/optimization_path/data/provider/remote/optimization_path_remote_data_source.dart';

final class OptimizationPathRemoteDataSourceImpl
    implements OptimizationPathRemoteDataSource {
  const OptimizationPathRemoteDataSourceImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  @override
  Future<ResponseDto> fetchTasks(
    String url,
  ) async {
    final response = await _restClient.get(
      url,
    ) as String;
    final jsonData = jsonDecode(response) as Map<String, dynamic>;

    return ResponseDto.fromJson(jsonData);
  }

  @override
  Future<SendResultResponse> sendResults({
    required List<ResultDto> results,
  }) async {
    final List<Map<String, dynamic>> jsonResults =
        results.map((result) => result.toJson()).toList();

    final response = await _restClient.post(
      'https://flutter.webspark.dev/flutter/api',
      body: jsonResults,
    ) as String;

    final jsonData = jsonDecode(response) as Map<String, dynamic>;

    return SendResultResponse.fromJson(jsonData);
  }
}
