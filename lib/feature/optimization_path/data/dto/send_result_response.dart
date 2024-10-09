import 'package:webspark/feature/optimization_path/data/dto/send_result_dto.dart';
import 'package:webspark/feature/optimization_path/data/entity/response_entity.dart';

class SendResultResponse extends ResponseEntity<SendResultDto> {
  const SendResultResponse({
    required super.error,
    required super.message,
    required super.data,
  });

  factory SendResultResponse.fromJson(Map<String, dynamic> json) {
    return SendResultResponse(
      error: json['error'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => SendResultDto.fromJson(item))
          .toList(),
    );
  }
}
