import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webspark/feature/optimization_path/data/dto/result_dto.dart';
import 'package:webspark/feature/optimization_path/data/repository/optimization_path_repository.dart';

part 'fetch_results_event.dart';

part 'fetch_results_state.dart';

class FetchResultsBloc extends Bloc<FetchResultsEvent, FetchResultsState> {
  FetchResultsBloc({
    required OptimizationPathRepository optimizationPathRepository,
  })  : _optimizationPathRepository = optimizationPathRepository,
        super(const FetchResultsIdle()) {
    on<FetchResultsEvent>((event, emit) => switch (event) {
          FetchResults() => _onFetchResults(event, emit),
        });
  }

  final OptimizationPathRepository _optimizationPathRepository;

  Future<void> _onFetchResults(
    FetchResults event,
    Emitter<FetchResultsState> emit,
  ) async {
    if (state.isLoading) return;
    try {
      emit(FetchResultsLoading(results: state.results));
      final results =
          await _optimizationPathRepository.fetchOptimizationPaths();
      emit(
        FetchResultsSuccessful(
          results: results,
        ),
      );
    } catch (error) {
      emit(FetchResultsFailure(message: error.toString()));
    } finally {
      emit(FetchResultsIdle(results: state.results));
    }
  }
}
