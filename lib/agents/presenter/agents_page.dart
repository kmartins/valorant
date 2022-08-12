import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:valorant/agents/domain/entities/agent.dart';
import 'package:valorant/agents/presenter/agents_view_model.dart';
import 'package:valorant/core/state/async_state.dart';
import 'package:valorant/core/utils/string_extension.dart';

class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  final viewModel = GetIt.I.get<AgentsViewModel>()..getAllAgents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agents'),
      ),
      body: ValueListenableBuilder<AsyncState<List<Agent>>>(
        valueListenable: viewModel,
        builder: (_, value, __) {
          if (value is AsyncLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = (value as AsyncData<List<Agent>>).result;
          return _AgentListWidget(agents: data);
        },
      ),
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}

class _AgentListWidget extends StatelessWidget {
  const _AgentListWidget({required this.agents});

  final List<Agent> agents;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: agents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (_, index) => _AgentItemWidget(
        agent: agents[index],
      ),
    );
  }
}

class _AgentItemWidget extends StatelessWidget {
  _AgentItemWidget({required this.agent});

  final Agent agent;
  late final agentColors =
      agent.backgroundGradientColors.map((value) => value.toColor()).toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          key: Key('container_${agent.displayName}'),
          margin: const EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: agentColors,
            ),
          ),
        ),
        Positioned(
          child: CachedNetworkImage(
            imageUrl: agent.image,
            fit: BoxFit.contain,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              agent.displayName,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
