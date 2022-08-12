import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/agents/infra/datasourcers/agent_local_data_source.dart';
import 'package:valorant/agents/infra/dtos/agent_dto.dart';

const _agentKey = 'agent';

class AgentLocalDataSourceImpl implements AgentLocalDataSource {
  AgentLocalDataSourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> saveAllAgents(List<AgentDto> agents) => _sharedPreferences
      .setStringList(_agentKey, agents.map((agent) => agent.toJson()).toList());

  @override
  Future<List<AgentDto>> selectAllAgents() async {
    final data = _sharedPreferences.getStringList(_agentKey);
    return data?.map(AgentDto.fromJson).toList() ?? [];
  }
}
