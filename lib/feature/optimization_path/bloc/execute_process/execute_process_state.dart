part of 'execute_process_bloc.dart';

sealed class ExecuteProcessState extends Equatable {
  const ExecuteProcessState({
    this.result = const [],
  });

  bool get isLoading => this is ExecuteProcessLoading;

  bool get isSuccessful => this is ExecuteProcessSuccessful;

  bool get hasError => this is ExecuteProcessFailure;

  bool get hasResult => result.isNotEmpty;

  bool get isRedirection =>
      this is ExecuteProcessSuccessful &&
      (this as ExecuteProcessSuccessful).isSuccessSend;

  final List<ResultDto> result;

  @override
  List<Object?> get props => [];
}

final class ExecuteProcessLoading extends ExecuteProcessState {
  const ExecuteProcessLoading({
    this.progress,
    super.result,
  });

  final double? progress;

  @override
  List<Object?> get props => [super.props, progress];
}

final class ExecuteProcessSuccessful extends ExecuteProcessState {
  const ExecuteProcessSuccessful({
    super.result,
    this.isSuccessSend = false,
  });

  final bool isSuccessSend;

  @override
  List<Object?> get props => [super.props, isRedirection];
}

final class ExecuteProcessFailure extends ExecuteProcessState {
  const ExecuteProcessFailure({
    required this.message,
    super.result,
  });

  final String message;

  @override
  List<Object?> get props => [super.props, message];
}

final class ExecuteProcessIdle extends ExecuteProcessState {
  const ExecuteProcessIdle({
    super.result,
  });
}
