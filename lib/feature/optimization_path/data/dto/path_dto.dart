import 'package:webspark/feature/optimization_path/data/dto/point_dto.dart';

class PathDto {
  final String id;
  final List<String> field;
  final PointDto start;
  final PointDto end;

  const PathDto({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory PathDto.fromJson(Map<String, dynamic> json) {
    return PathDto(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: PointDto.fromJson(json['start']),
      end: PointDto.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}
