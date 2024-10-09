import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webspark/core/client/rest/rest_client.dart';
import 'package:webspark/core/utils/mixin/api_call_mixin.dart';

final class HttpRestClient with ApiCallMixin implements RestClient {
  const HttpRestClient();

  @override
  Future<Object> get(String endpoint) async => execute(() async {
        final response = await http.get(Uri.parse(endpoint));
        return response.body;
      });

  @override
  Future<Object> post(
    String endpoint, {
    dynamic body,
  }) async =>
      execute(() async {
        final response = await http.post(
          Uri.parse(endpoint),
          headers: {'Content-Type': 'application/json'},
          body: body != null ? jsonEncode(body) : null,
        );
        return response.body;
      });
}
