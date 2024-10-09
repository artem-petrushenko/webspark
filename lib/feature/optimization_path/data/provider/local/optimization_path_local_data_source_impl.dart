import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:webspark/core/client/database/drift/database.dart';
import 'package:webspark/core/utils/enums.dart';
import 'package:webspark/feature/optimization_path/data/dto/result_dto.dart';
import 'package:webspark/feature/optimization_path/data/provider/local/optimization_path_local_data_source.dart';

final class OptimizationPathLocalDataSourceImpl
    implements OptimizationPathLocalDataSource {
  const OptimizationPathLocalDataSourceImpl({
    required final AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  @override
  Future<void> addOptimizationPath({
    required final ResultDto result,
  }) async {
    List<List<String>> pointsAsStrings = result.resultPoints
        .map((points) => points.map((point) => point.toString()).toList())
        .toList();

    String pointsJson = jsonEncode(pointsAsStrings);
    _database.into(_database.resultInstruction).insert(
          ResultInstructionCompanion.insert(
            id: result.id,
            path: result.path,
            points: Value(pointsJson),
          ),
        );
  }

  @override
  Future<ResultDto> fetchOptimizationPath({
    required final String id,
  }) async {
    final records = await (_database.select(_database.resultInstruction)
          ..where((tbl) => tbl.id.equals(id)))
        .get();

    if (records.isEmpty) {
      throw Exception('Record not found for ID: $id');
    }

    final record = records.first;

    return ResultDto(
      id: record.id,
      path: record.path,
      resultPoints: _parsePoints(record.points),
    );
  }

  @override
  Future<List<ResultDto>> fetchOptimizationPaths() async {
    final result = await _database.select(_database.resultInstruction).get();

    return result.map((record) {
      return ResultDto(
        id: record.id,
        path: record.path,
        resultPoints: _parsePoints(record.points),
      );
    }).toList();
  }

  List<List<ResultPointType>> _parsePoints(String pointsJson) {
    return (jsonDecode(pointsJson) as List<dynamic>)
        .map((outerList) => (outerList as List<dynamic>)
            .map((point) =>
                ResultPointType.values.firstWhere((e) => e.toString() == point))
            .toList())
        .toList();
  }
}
