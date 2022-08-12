import 'package:valorant/core/services/http_response.dart';

// ignore: one_member_abstracts
abstract class HttpAdapter {
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}
