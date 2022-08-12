import 'package:valorant/agents/domain/entities/agent.dart';

// ignore: one_member_abstracts
abstract class AgentRepository {
  Future<List<Agent>> getAllAgents();
}
