import 'package:equatable/equatable.dart';
import 'package:webspark/core/utils/enums.dart';

class ResultDto extends Equatable {
  const ResultDto({
    required this.id,
    required this.path,
    required this.resultPoints,
  });

  final String id;
  final String path;
  final List<List<ResultPointType>> resultPoints;

  @override
  List<Object?> get props => [id, path];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': {
        'steps': _parsePathToSteps(path),
        'path': path,
      },
    };
  }

  List<Map<String, String>> _parsePathToSteps(String path) {
    final steps = path.split('->').map((step) {
      final coords = step.replaceAll('(', '').replaceAll(')', '').split(',');
      return {
        'x': coords[0],
        'y': coords[1],
      };
    }).toList();

    return steps;
  }
}
