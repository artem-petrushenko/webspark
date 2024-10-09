import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/feature/optimization_path/bloc/fetch_result_details/fetch_result_details_bloc.dart';

class ResultDetailsScreen extends StatelessWidget {
  const ResultDetailsScreen({
    super.key,
    required this.id,
    required this.fetchResultDetailsBloc,
  });

  final String id;
  final FetchResultDetailsBloc fetchResultDetailsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchResultDetailsBloc>(
      create: (context) =>
          fetchResultDetailsBloc..add(const FetchResultDetails()),
      child: Scaffold(
          body: BlocBuilder<FetchResultDetailsBloc, FetchResultDetailsState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Result Details'),
              ),
              if (state.isLoading && !state.hasResults)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (!state.isLoading && !state.hasResults)
                const SliverFillRemaining(
                  child: Center(
                    child: Text('No results found'),
                  ),
                ),
              if (state.hasResults)
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: state.result!.resultPoints[0].length,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final int x =
                          index % state.result!.resultPoints[0].length;
                      final int y =
                          index ~/ state.result!.resultPoints[0].length;

                      return ColoredBox(
                        color: state.result!.resultPoints[y][x].color,
                        child: Center(
                          child: Text(
                            '$x,$y',
                          ),
                        ),
                      );
                    },
                    childCount: state.result!.resultPoints.length *
                        state.result!.resultPoints[0].length,
                  ),
                ),
              if (state.hasResults)
                SliverToBoxAdapter(
                  child: Text('Path: ${state.result!.path}'),
                )
            ],
          );
        },
      )),
    );
  }
}
