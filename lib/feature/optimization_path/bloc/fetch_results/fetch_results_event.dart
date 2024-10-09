part of 'fetch_results_bloc.dart';

sealed class FetchResultsEvent extends Equatable {
  const FetchResultsEvent();

  @override
  List<Object> get props => [];
}

final class FetchResults extends FetchResultsEvent {
  const FetchResults();
}
