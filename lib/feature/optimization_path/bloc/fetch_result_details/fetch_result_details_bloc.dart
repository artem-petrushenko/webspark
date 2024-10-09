import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webspark/feature/optimization_path/data/dto/result_dto.dart';
import 'package:webspark/feature/optimization_path/data/repository/optimization_path_repository.dart';

part 'fetch_result_details_event.dart';

part 'fetch_result_details_state.dart';

class FetchResultDetailsBloc
    extends Bloc<FetchResultDetailsEvent, FetchResultDetailsState> {
  FetchResultDetailsBloc(
    this._id, {
    required OptimizationPathRepository optimizationPathRepository,
  })  : _optimizationPathRepository = optimizationPathRepository,
        super(const FetchResultDetailsIdle()) {
    on<FetchResultDetailsEvent>((event, emit) => switch (event) {
          FetchResultDetails() => _onFetchResultDetails(event, emit),
        });
  }

  final String _id;
  final OptimizationPathRepository _optimizationPathRepository;

  Future<void> _onFetchResultDetails(
    FetchResultDetails event,
    Emitter<FetchResultDetailsState> emit,
  ) async {
    if (state.isLoading) return;
    emit(FetchResultDetailsLoading(result: state.result));
    try {
      final result =
          await _optimizationPathRepository.fetchOptimizationPath(id: _id);
      emit(
        FetchResultDetailsSuccess(
          result: result,
        ),
      );
    } catch (e) {
      emit(FetchResultDetailsFailure(
        result: state.result,
        message: e.toString(),
      ));
    } finally {
      emit(FetchResultDetailsIdle(result: state.result));
    }
  }
}
