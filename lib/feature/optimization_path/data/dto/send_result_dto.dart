import 'package:equatable/equatable.dart';

class SendResultDto extends Equatable {
  final String id;
  final bool correct;

  const SendResultDto({
    required this.id,
    required this.correct,
  });

  @override
  List<Object?> get props => [id, correct];

  factory SendResultDto.fromJson(Map<String, dynamic> json) {
    return SendResultDto(
      id: json['id'] as String,
      correct: json['correct'] as bool,
    );
  }
}
