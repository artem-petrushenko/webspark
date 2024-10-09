mixin ApiCallMixin {
  Future<T> execute<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
