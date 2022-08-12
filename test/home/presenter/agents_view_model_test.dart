import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:valorant/agents/domain/entities/agent.dart';
import 'package:valorant/agents/domain/usecases/get_all_agents.dart';
import 'package:valorant/agents/presenter/agents_view_model.dart';
import 'package:valorant/core/state/async_state.dart';

class GetAllAgentsMock extends Mock implements GetAllAgents {}

const agents = [
  Agent(
    id: '0',
    displayName: 'test',
    image: 'image',
    backgroundGradientColors: [],
  )
];

void main() {
  group('AgentsViewModel', () {
    test(
      'deve ter o estado de carregamento enquanto busca a lista de agentes',
      () {
        final getAllAgentsMock = GetAllAgentsMock();
        final viewModel = AgentsViewModel(getAllAgentsMock);
        expect(viewModel.value, isA<AsyncLoading<List<Agent>>>());
      },
    );

    test(
      'deve ter o estado de dados com a lista de agentes',
      () async {
        final completer = Completer<List<Agent>>();
        final getAllAgentsMock = GetAllAgentsMock();
        final viewModel = AgentsViewModel(getAllAgentsMock);
        when(getAllAgentsMock).thenAnswer((_) => completer.future);
        viewModel.getAllAgents();
        completer.complete(agents);
        expect(viewModel.value, isA<AsyncLoading<List<Agent>>>());
        await completer.future;
        expect(
          viewModel.value,
          isA<AsyncData<List<Agent>>>()
              .having((asyncData) => asyncData.result, 'result', agents),
        );
      },
    );
  });
}
