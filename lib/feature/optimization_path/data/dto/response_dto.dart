import 'package:webspark/feature/optimization_path/data/dto/path_dto.dart';
import 'package:webspark/feature/optimization_path/data/entity/response_entity.dart';

class ResponseDto extends ResponseEntity<PathDto> {
  const ResponseDto({
    required super.error,
    required super.message,
    required super.data,
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) {
    return ResponseDto(
      error: json['error'],
      message: json['message'],
      data:
          (json['data'] as List).map((item) => PathDto.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
