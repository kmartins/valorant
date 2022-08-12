import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:valorant/agents/domain/entities/agent.dart';
import 'package:valorant/agents/domain/usecases/get_all_agents.dart';
import 'package:valorant/agents/presenter/agents_page.dart';
import 'package:valorant/agents/presenter/agents_view_model.dart';

class GetAllAgentsMock extends Mock implements GetAllAgents {}

const gradientColors = [];

const agents = [
  Agent(
    id: '0',
    displayName: 'Brim',
    image: 'image',
    backgroundGradientColors: [
      'b1414cff',
      '5589bdff',
      '18344cff',
      '66376cff',
    ],
  )
];

void main() {
  group('AgentsPage', () {
    testWidgets(
      'deve aparecer um loading enquanto espera a lista de agentes',
      (tester) async {
        final completer = Completer<List<Agent>>();
        final getAllAgentsMock = GetAllAgentsMock();
        GetIt.instance.registerFactory<AgentsViewModel>(
          () => AgentsViewModel(getAllAgentsMock),
        );
        when(getAllAgentsMock).thenAnswer((_) => completer.future);
        await tester.pumpWidget(
          const MaterialApp(
            home: AgentsPage(),
          ),
        );
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'deve aparecer um grid com os agentes ao acabar de carregar',
      (tester) async {
        final completer = Completer<List<Agent>>();
        final getAllAgentsMock = GetAllAgentsMock();
        GetIt.instance.registerFactory<AgentsViewModel>(
          () => AgentsViewModel(getAllAgentsMock),
        );
        when(getAllAgentsMock).thenAnswer((_) => completer.future);
        await tester.pumpWidget(
          const MaterialApp(
            home: AgentsPage(),
          ),
        );
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        completer.complete(agents);
        await tester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(GridView), findsOneWidget);
        expect(find.text('Brim'), findsOneWidget);
        final container =
            tester.widget<Container>(find.byKey(const Key('container_Brim')));
        final gradient = (container.decoration! as BoxDecoration).gradient!;
        expect(gradient.colors, contains(const Color(0xffb1414c)));
      },
    );
  });
}
