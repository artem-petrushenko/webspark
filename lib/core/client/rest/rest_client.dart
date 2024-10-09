abstract interface class RestClient {
  const RestClient();

  Future<Object> get(
    String endpoint,
  );

  Future<Object> post(
    String endpoint, {
    dynamic body,
  });
}
