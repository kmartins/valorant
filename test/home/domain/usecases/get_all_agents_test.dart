import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:valorant/agents/domain/entities/agent.dart';
import 'package:valorant/agents/domain/repositories/agent_repository.dart';
import 'package:valorant/agents/domain/usecases/get_all_agents.dart';

class AgentRepositoryMock extends Mock implements AgentRepository {}

void main() {
  group('GetAllAgents', () {
    test('deve retornar uma lista de agentes', () async {
      final repository = AgentRepositoryMock();
      final getAllAgents = GetAllAgents(repository);
      const agents = [
        Agent(
          id: '0',
          displayName: 'test',
          image: 'image',
          backgroundGradientColors: [],
        )
      ];
      when(repository.getAllAgents).thenAnswer((_) async => agents);
      final data = await getAllAgents();
      expect(data, agents);
      verify(repository.getAllAgents).called(1);
    });
  });
}
