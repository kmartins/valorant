import 'dart:io';

import 'package:valorant/agents/domain/entities/agent.dart';
import 'package:valorant/agents/domain/repositories/agent_repository.dart';
import 'package:valorant/agents/infra/datasourcers/agent_local_data_source.dart';
import 'package:valorant/agents/infra/datasourcers/agent_network_data_source.dart';

class AgentRepositoryImpl implements AgentRepository {
  const AgentRepositoryImpl(
    this._agentNetworkDataSource,
    this._agentLocalDataSource,
  );

  final AgentNetworkDataSource _agentNetworkDataSource;
  final AgentLocalDataSource _agentLocalDataSource;

  @override
  Future<List<Agent>> getAllAgents() async {
    try {
      final agents = await _agentNetworkDataSource.fetchAllAgents();
      await _agentLocalDataSource.saveAllAgents(agents);
      return agents.map((agent) => agent.toEntity()).toList();
    } on SocketException {
      final agents = await _agentLocalDataSource.selectAllAgents();
      return agents.map((agent) => agent.toEntity()).toList();
    }
  }
}
