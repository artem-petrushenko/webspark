part of 'fetch_result_details_bloc.dart';

sealed class FetchResultDetailsState extends Equatable {
  const FetchResultDetailsState({
    this.result,
  });

  final ResultDto? result;

  bool get isLoading => this is FetchResultDetailsLoading;

  bool get hasResults => result != null;

  @override
  List<Object?> get props => [result];
}

final class FetchResultDetailsIdle extends FetchResultDetailsState {
  const FetchResultDetailsIdle({
    super.result,
  });
}

final class FetchResultDetailsLoading extends FetchResultDetailsState {
  const FetchResultDetailsLoading({
    super.result,
  });
}

final class FetchResultDetailsSuccess extends FetchResultDetailsState {
  const FetchResultDetailsSuccess({
    required ResultDto result,
  }) : super(result: result);
}

final class FetchResultDetailsFailure extends FetchResultDetailsState {
  const FetchResultDetailsFailure({
    super.result,
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
