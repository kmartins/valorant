import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/agents/external/datasources/agent_local_data_source_impl.dart';
import 'package:valorant/agents/infra/dtos/agent_dto.dart';

const agents = [
  AgentDto(
    id: '123',
    displayName: 'brim',
    image: 'image',
    backgroundGradientColors: [],
  ),
];

void main() {
  late SharedPreferences preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
  });

  tearDown(() async => preferences.clear());

  group('AgentLocalDataSourceImpl', () {
    test('deve obter uma lista de agentes da preferências', () async {
      final local = AgentLocalDataSourceImpl(preferences);
      var data = await local.selectAllAgents();
      expect(data, isEmpty);
      await local.saveAllAgents(agents);
      data = await local.selectAllAgents();
      expect(data, agents);
    });

    test('deve salvar uma lista de agentes da preferências', () async {
      final local = AgentLocalDataSourceImpl(preferences);
      await local.saveAllAgents(agents);
      final data = await local.selectAllAgents();
      expect(data, agents);
    });
  });
}
