import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webspark/core/utils/enums.dart';
import 'package:webspark/feature/optimization_path/data/dto/path_dto.dart';
import 'package:webspark/feature/optimization_path/data/dto/point_dto.dart';
import 'package:webspark/feature/optimization_path/data/dto/result_dto.dart';
import 'package:webspark/feature/optimization_path/data/repository/optimization_path_repository.dart';

part 'execute_process_event.dart';

part 'execute_process_state.dart';

class ExecuteProcessBloc
    extends Bloc<ExecuteProcessEvent, ExecuteProcessState> {
  ExecuteProcessBloc({
    required OptimizationPathRepository optimizationPathRepository,
  })  : _optimizationPathRepository = optimizationPathRepository,
        super(const ExecuteProcessIdle()) {
    on<ExecuteProcessEvent>((event, emit) => switch (event) {
          ExecuteProcessFetchTask() => _onFetchTask(event, emit),
          SendShortPath() => _onSendShortPath(event, emit),
        });
  }

  final OptimizationPathRepository _optimizationPathRepository;
  List<List<ResultPointType>> gridMatrix = [];

  Future<void> _onFetchTask(
    ExecuteProcessFetchTask event,
    Emitter<ExecuteProcessState> emit,
  ) async {
    if (state.isLoading) return;
    emit(const ExecuteProcessLoading());
    List<ResultDto> results = [];
    try {
      final response = await _optimizationPathRepository.fetchTasks(
        event.url,
      );
      if (response.error) {
        emit(ExecuteProcessFailure(result: results, message: response.message));
      } else {
        for (PathDto path in response.data) {
          List<PointDto> pathResult = findShortestPath(path);

          ResultDto resultDto = ResultDto(
            id: path.id,
            path: pathResult.map((e) => '(${e.x},${e.y})').join('->'),
            resultPoints: gridMatrix,
          );

          results.add(resultDto);
        }
        emit(ExecuteProcessSuccessful(result: results));
      }
    } catch (error) {
      emit(ExecuteProcessFailure(result: results, message: error.toString()));
    } finally {
      emit(ExecuteProcessIdle(result: results));
    }
  }

  Future<void> _onSendShortPath(
    SendShortPath event,
    Emitter<ExecuteProcessState> emit,
  ) async {
    if (state.isLoading && state.hasResult) return;
    try {
      emit(ExecuteProcessLoading(
        result: state.result,
      ));
      final response =
          await _optimizationPathRepository.sendResults(results: state.result);
      if (response.error) {
        emit(ExecuteProcessFailure(
          result: state.result,
          message: response.message,
        ));
      } else {
        emit(ExecuteProcessSuccessful(
          result: state.result,
          isSuccessSend: true,
        ));
      }
    } catch (error) {
      emit(ExecuteProcessFailure(
        result: state.result,
        message: error.toString(),
      ));
    } finally {
      emit(ExecuteProcessIdle(
        result: state.result,
      ));
    }
  }

  List<PointDto> findShortestPath(PathDto path) {
    List<PointDto> shortestPath = [];
    Queue<PointDto> queue = Queue();
    Set<String> visited = {};
    Map<String, PointDto?> parentMap = {};
    final start = path.start;
    final end = path.end;

    _initializeGridMatrix(path);

    queue.add(start);
    visited.add('${start.x},${start.y}');
    parentMap['${start.x},${start.y}'] = null;

    while (queue.isNotEmpty) {
      PointDto current = queue.removeFirst();

      if (_isEndPoint(current, end)) {
        shortestPath = _constructShortestPath(current, parentMap);
        _markStartAndEnd(start, end);
        return shortestPath;
      }

      for (PointDto direction in _directions) {
        int newX = current.x + direction.x;
        int newY = current.y + direction.y;

        if (_canMove(newX, newY, path, visited)) {
          visited.add('$newX,$newY');
          queue.add(PointDto(newX, newY));
          parentMap['$newX,$newY'] = current;
        }
      }
    }

    return [];
  }

  void _initializeGridMatrix(PathDto path) {
    gridMatrix = List.generate(
      path.field.length,
      (i) => List.generate(
        path.field[0].length,
        (j) => ResultPointType.empty,
      ),
    );

    for (int i = 0; i < path.field.length; i++) {
      for (int j = 0; j < path.field[0].length; j++) {
        if (path.field[i][j] == 'X') {
          gridMatrix[i][j] = ResultPointType.block;
        }
      }
    }
  }

  List<PointDto> _constructShortestPath(
      PointDto endPoint, Map<String, PointDto?> parentMap) {
    List<PointDto> path = [];
    PointDto? backtrack = endPoint;

    while (backtrack != null) {
      path.insert(0, backtrack);
      gridMatrix[backtrack.x][backtrack.y] = ResultPointType.path;
      backtrack = parentMap['${backtrack.x},${backtrack.y}'];
    }

    return path;
  }

  bool _canMove(int newX, int newY, PathDto path, Set<String> visited) {
    return newX >= 0 &&
        newY >= 0 &&
        newX < path.field.length &&
        newY < path.field[0].length &&
        path.field[newX][newY] != 'X' &&
        !visited.contains('$newX,$newY');
  }

  bool _isEndPoint(PointDto current, PointDto end) {
    return current.x == end.x && current.y == end.y;
  }

  void _markStartAndEnd(PointDto start, PointDto end) {
    gridMatrix[start.x][start.y] = ResultPointType.start;
    gridMatrix[end.x][end.y] = ResultPointType.end;
  }

  final List<PointDto> _directions = const [
    PointDto(0, 1),
    PointDto(1, 0),
    PointDto(0, -1),
    PointDto(-1, 0),
    PointDto(1, 1),
    PointDto(1, -1),
    PointDto(-1, 1),
    PointDto(-1, -1),
  ];
}
