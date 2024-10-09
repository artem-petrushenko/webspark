part of 'execute_process_bloc.dart';

sealed class ExecuteProcessEvent extends Equatable {
  const ExecuteProcessEvent();

  @override
  List<Object> get props => [];
}

final class ExecuteProcessFetchTask extends ExecuteProcessEvent {
  const ExecuteProcessFetchTask({
    required this.url,
  });

  final String url;
}

final class SendShortPath extends ExecuteProcessEvent {
  const SendShortPath();
}
