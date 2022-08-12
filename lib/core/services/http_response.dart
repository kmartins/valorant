import 'package:flutter/foundation.dart';

@immutable
class HttpResponse {
  const HttpResponse({
    required this.data,
    required this.statusCode,
  });

  final String data;
  final int statusCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HttpResponse &&
        other.data == data &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => data.hashCode ^ statusCode.hashCode;

  @override
  String toString() => 'HttpResponse(data: $data, statusCode: $statusCode)';
}
