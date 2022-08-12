import 'dart:convert';

import 'package:valorant/agents/infra/datasourcers/agent_network_data_source.dart';
import 'package:valorant/agents/infra/dtos/agent_dto.dart';
import 'package:valorant/core/services/http_adapter.dart';

class AgentNetworkDataSourceImpl implements AgentNetworkDataSource {
  const AgentNetworkDataSourceImpl(this._httpAdapter);

  final HttpAdapter _httpAdapter;

  @override
  Future<List<AgentDto>> fetchAllAgents() async {
    final response = await _httpAdapter.get(
      'https://valorant-api.com/v1/agents',
      queryParameters: {'isPlayableCharacter': 'true'},
    );
    final result = jsonDecode(response.data) as Map<String, dynamic>;
    final data = (result['data'] as List).cast<Map<String, dynamic>>();
    return data.map(AgentDto.fromMap).toList();
  }
}
