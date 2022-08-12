import 'package:valorant/agents/infra/dtos/agent_dto.dart';

// ignore: one_member_abstracts
abstract class AgentNetworkDataSource {
  AgentNetworkDataSource();

  Future<List<AgentDto>> fetchAllAgents();
}
