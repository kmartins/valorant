import 'package:http/http.dart';
import 'package:valorant/core/services/http_adapter.dart';
import 'package:valorant/core/services/http_response.dart';

class HttpService implements HttpAdapter {
  const HttpService(this._client);

  final Client _client;

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse(path).replace(queryParameters: queryParameters);
    final response = await _client.get(uri);
    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }
}
