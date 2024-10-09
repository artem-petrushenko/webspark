import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/core/route/route.dart';
import 'package:webspark/feature/optimization_path/bloc/execute_process/execute_process_bloc.dart';

class ExecuteProcessScreen extends StatelessWidget {
  const ExecuteProcessScreen({
    super.key,
    required this.executeProcessBloc,
    required this.url,
  });

  final ExecuteProcessBloc executeProcessBloc;
  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExecuteProcessBloc>(
      create: (context) =>
          executeProcessBloc..add(ExecuteProcessFetchTask(url: url)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Execute Process'),
        ),
        body: BlocConsumer<ExecuteProcessBloc, ExecuteProcessState>(
          listener: (context, state) {
            if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text((state as ExecuteProcessFailure).message)));
            }
            if(state.isRedirection){
              Navigator.pushNamed(context, RoutePath.result);
            }
          },
          builder: (context, state) => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isLoading)
                  CircularProgressIndicator(
                    value: (state as ExecuteProcessLoading).progress,
                  ),
                if (state.hasResult)
                  ElevatedButton(
                      onPressed: () {
                        if (state.isLoading) return;
                        context
                            .read<ExecuteProcessBloc>()
                            .add(const SendShortPath());
                      },
                      child: const Text('Send Result')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
