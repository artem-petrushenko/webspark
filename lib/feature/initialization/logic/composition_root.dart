import 'dart:developer';

import 'package:webspark/core/client/database/drift/database.dart';
import 'package:webspark/core/client/rest/http_rest_client.dart';
import 'package:webspark/feature/initialization/model/dependencies.dart';
import 'package:webspark/feature/optimization_path/data/provider/local/optimization_path_local_data_source_impl.dart';
import 'package:webspark/feature/optimization_path/data/provider/remote/optimization_path_remote_data_source_impl.dart';
import 'package:webspark/feature/optimization_path/data/repository/optimization_path_repository_impl.dart';

final class CompositionRoot {
  const CompositionRoot();

  Future<Dependencies> compose() async {
    log('Initializing dependencies...');
    final dependencies = await _initDependencies();
    log('Dependencies initialized');

    return dependencies;
  }

  Future<Dependencies> _initDependencies() async {
    final database = AppDatabase();
    const restClient = HttpRestClient();
    const optimizationPathRemoteDataSource =
        OptimizationPathRemoteDataSourceImpl(
      restClient: restClient,
    );
    final optimizationPathLocalDataSource =
        OptimizationPathLocalDataSourceImpl(database: database);
    final optimizationPathRepository = OptimizationPathRepositoryImpl(
      remoteDataSource: optimizationPathRemoteDataSource,
      localDataSource: optimizationPathLocalDataSource,
    );

    return Dependencies(
      optimizationPathRepository: optimizationPathRepository,
    );
  }
}
