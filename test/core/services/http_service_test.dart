import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:valorant/core/services/http_service.dart';

class HttpMock extends Mock implements Client {}

void main() {
  group('HttpService', () {
    test('deve retornar o corpo e o código de status da resposta da requisição',
        () async {
      final uri = Uri.parse('get');
      final httpMock = HttpMock();
      final httpService = HttpService(httpMock);
      when(() => httpMock.get(uri))
          .thenAnswer((_) async => Response('response', 200));
      final httpResponse = await httpService.get('get');
      expect(httpResponse.data, 'response');
      expect(httpResponse.statusCode, 200);
      verify(() => httpMock.get(uri)).called(1);
    });

    test(
        'deve retornar o corpo e o código de status da resposta da requisição '
        'quando passado uma query', () async {
      final uri = Uri.parse('get').replace(queryParameters: {'value': '1'});
      final httpMock = HttpMock();
      final httpService = HttpService(httpMock);
      when(() => httpMock.get(uri))
          .thenAnswer((_) async => Response('response', 200));
      final httpResponse =
          await httpService.get('get', queryParameters: {'value': '1'});
      expect(httpResponse.data, 'response');
      expect(httpResponse.statusCode, 200);
      verify(() => httpMock.get(uri)).called(1);
    });
  });
}
