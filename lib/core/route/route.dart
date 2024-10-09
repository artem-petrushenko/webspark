import 'package:flutter/material.dart';
import 'package:webspark/feature/initialization/widget/dependencies_scope.dart';
import 'package:webspark/feature/optimization_path/bloc/execute_process/execute_process_bloc.dart';
import 'package:webspark/feature/optimization_path/bloc/fetch_result_details/fetch_result_details_bloc.dart';
import 'package:webspark/feature/optimization_path/bloc/fetch_results/fetch_results_bloc.dart';
import 'package:webspark/feature/optimization_path/widget/execute_process_screen.dart';
import 'package:webspark/feature/optimization_path/widget/result_screen.dart';
import 'package:webspark/feature/optimization_path/widget/result_details_screen.dart';
import 'package:webspark/feature/optimization_path/widget/url_handler_screen.dart';

abstract class RoutePath {
  const RoutePath._();

  static const String urlHandlerDetails = '/url_handler_details';
  static const String urlHandler = '/url_handler';
  static const String resultDetails = '/result/:id';
  static const String result = '/result';
}

class Routing {
  const Routing._();

  static RouteFactory onGenerateRoute = (settings) {
    final uri = Uri.parse(settings.name!);

    switch (uri.path) {
      case RoutePath.urlHandler:
        return _buildUrlHandlerRoute();
      case RoutePath.result:
        return _buildResultRoute();
    }

    if (uri.path == RoutePath.urlHandlerDetails) {
      final arguments = settings.arguments as Map<String, dynamic>;
      return _buildExecuteProcessRoute(arguments['url']);
    }

    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'result') {
      final id = uri.pathSegments[1];
      return _buildResultDetailsRoute(id);
    }

    return null;
  };

  static MaterialPageRoute _buildExecuteProcessRoute(String url) {
    return MaterialPageRoute(
      builder: (context) {
        final optimizationPathRepository =
            DependenciesScope.of(context).optimizationPathRepository;
        return ExecuteProcessScreen(
          executeProcessBloc: ExecuteProcessBloc(
              optimizationPathRepository: optimizationPathRepository),
          url: url,
        );
      },
    );
  }

  static MaterialPageRoute _buildUrlHandlerRoute() {
    return MaterialPageRoute(
      builder: (context) => const UrlHandlerScreen(),
    );
  }

  static MaterialPageRoute _buildResultDetailsRoute(String id) {
    return MaterialPageRoute(
      builder: (context) => ResultDetailsScreen(
        id: id,
        fetchResultDetailsBloc: FetchResultDetailsBloc(
          id,
          optimizationPathRepository:
              DependenciesScope.of(context).optimizationPathRepository,
        ),
      ),
    );
  }

  static MaterialPageRoute _buildResultRoute() {
    return MaterialPageRoute(
      builder: (context) {
        final optimizationPathRepository =
            DependenciesScope.of(context).optimizationPathRepository;
        return ResultScreen(
          fetchResultsBloc: FetchResultsBloc(
              optimizationPathRepository: optimizationPathRepository),
        );
      },
    );
  }
}
