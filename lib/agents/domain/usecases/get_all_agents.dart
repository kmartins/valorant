import 'package:valorant/agents/domain/entities/agent.dart';
import 'package:valorant/agents/domain/repositories/agent_repository.dart';

class GetAllAgents {
  GetAllAgents(this._agentRepository);

  final AgentRepository _agentRepository;

  Future<List<Agent>> call() => _agentRepository.getAllAgents();
}
