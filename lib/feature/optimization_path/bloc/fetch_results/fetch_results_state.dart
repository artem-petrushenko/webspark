part of 'fetch_results_bloc.dart';

sealed class FetchResultsState extends Equatable {
  const FetchResultsState({
    this.results = const [],
  });

  final List<ResultDto> results;

  bool get isLoading => this is FetchResultsLoading;

  bool get hasResults => results.isNotEmpty;

  @override
  List<Object> get props => [results];
}

final class FetchResultsIdle extends FetchResultsState {
  const FetchResultsIdle({super.results});
}

final class FetchResultsLoading extends FetchResultsState {
  const FetchResultsLoading({super.results});
}

final class FetchResultsSuccessful extends FetchResultsState {
  const FetchResultsSuccessful({super.results});
}

final class FetchResultsFailure extends FetchResultsState {
  const FetchResultsFailure({
    super.results,
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [super.props, message];
}
