import 'package:valorant/agents/infra/dtos/agent_dto.dart';

abstract class AgentLocalDataSource {
  Future<List<AgentDto>> selectAllAgents();
  Future<void> saveAllAgents(List<AgentDto> agents);
}
