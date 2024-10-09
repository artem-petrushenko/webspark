part of 'fetch_result_details_bloc.dart';

sealed class FetchResultDetailsEvent extends Equatable {
  const FetchResultDetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchResultDetails extends FetchResultDetailsEvent {
  const FetchResultDetails();
}
