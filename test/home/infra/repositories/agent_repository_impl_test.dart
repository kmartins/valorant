import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:valorant/agents/infra/datasourcers/agent_local_data_source.dart';
import 'package:valorant/agents/infra/datasourcers/agent_network_data_source.dart';
import 'package:valorant/agents/infra/dtos/agent_dto.dart';
import 'package:valorant/agents/infra/repositories/agent_repository_impl.dart';

class AgentLocalDataSourceMock extends Mock implements AgentLocalDataSource {}

class AgentNetworkDataSourceMock extends Mock
    implements AgentNetworkDataSource {}

const agents = [
  AgentDto(
    id: '123',
    displayName: 'brim',
    image: 'image',
    backgroundGradientColors: [],
  ),
];

void main() {
  final networkDataSource = AgentNetworkDataSourceMock();
  final localDataSource = AgentLocalDataSourceMock();

  tearDown(() {
    reset(networkDataSource);
    reset(localDataSource);
  });

  group('AgentRepositoryImpl', () {
    test(
        'deve retornar uma lista de agentes vindo do network e salvar no local',
        () async {
      final repository =
          AgentRepositoryImpl(networkDataSource, localDataSource);
      when(networkDataSource.fetchAllAgents).thenAnswer((_) async => agents);
      when(() => localDataSource.saveAllAgents(agents))
          .thenAnswer((_) async {});
      final data = await repository.getAllAgents();
      expect(data, agents.map((item) => item.toEntity()).toList());
      verify(networkDataSource.fetchAllAgents).called(1);
      verify(() => localDataSource.saveAllAgents(agents)).called(1);
      verifyNever(localDataSource.selectAllAgents);
    });

    test(
      'deve retornar uma lista de agentes local quando dá erro de rede',
      () async {
        final repository =
            AgentRepositoryImpl(networkDataSource, localDataSource);
        when(networkDataSource.fetchAllAgents).thenThrow(
          const SocketException('error'),
        );
        when(localDataSource.selectAllAgents).thenAnswer((_) async => agents);
        final data = await repository.getAllAgents();
        expect(data, agents.map((item) => item.toEntity()).toList());
        verify(networkDataSource.fetchAllAgents).called(1);
        verify(localDataSource.selectAllAgents).called(1);
        verifyNever(() => localDataSource.saveAllAgents(agents));
      },
    );
  });
}
