import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/core/route/route.dart';
import 'package:webspark/feature/optimization_path/bloc/fetch_results/fetch_results_bloc.dart';
import 'package:webspark/feature/optimization_path/widget/result_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.fetchResultsBloc,
  });

  final FetchResultsBloc fetchResultsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchResultsBloc>(
      create: (context) => fetchResultsBloc..add(const FetchResults()),
      child: Scaffold(body: BlocBuilder<FetchResultsBloc, FetchResultsState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Results'),
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ResultCard(
                        title: state.results[index].path,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '${RoutePath.result}/${state.results[index].id}',
                        ),
                      );
                    },
                    childCount: state.results.length,
                  ),
                ),
            ],
          );
        },
      )),
    );
  }
}
