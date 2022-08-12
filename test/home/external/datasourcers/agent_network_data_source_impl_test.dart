import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:valorant/agents/external/datasources/agent_network_data_source_impl.dart';
import 'package:valorant/core/services/http_response.dart';
import 'package:valorant/core/services/http_service.dart';

import '../../../files.dart';

class HttpServiceMock extends Mock implements HttpService {}

void main() {
  group('AgentNetworkDataSource', () {
    test('deve solicitar e retornar uma lista de agentes da api', () async {
      final httpService = HttpServiceMock();
      final networkDataSource = AgentNetworkDataSourceImpl(httpService);
      // ignore: prefer_function_declarations_over_variables
      final callHttp = () => httpService.get(
            'https://valorant-api.com/v1/agents',
            queryParameters: {'isPlayableCharacter': 'true'},
          );
      when(
        callHttp,
      ).thenAnswer(
        (_) async => HttpResponse(data: agentsJson, statusCode: 200),
      );
      final data = await networkDataSource.fetchAllAgents();
      expect(data.length, 1);
      expect(data.first.displayName, 'Fade');
      verify(callHttp).called(1);
    });
  });
}
