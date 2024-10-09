import 'package:equatable/equatable.dart';

class ResponseEntity<T> extends Equatable {
  final bool error;
  final String message;
  final List<T> data;

  const ResponseEntity({
    required this.error,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [error, message, data];
}
