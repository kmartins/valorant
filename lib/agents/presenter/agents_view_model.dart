import 'dart:async';

import 'package:valorant/agents/domain/entities/agent.dart';
import 'package:valorant/agents/domain/usecases/get_all_agents.dart';
import 'package:valorant/core/state/async_state.dart';
import 'package:valorant/core/state/base_view_model.dart';

class AgentsViewModel extends BaseViewModel<AsyncState<List<Agent>>> {
  AgentsViewModel(this._getAllAgents) : super(const AsyncState.loading());

  final GetAllAgents _getAllAgents;
  StreamSubscription<List<Agent>>? _streamSubscription;

  void getAllAgents() {
    value = const AsyncState.loading();
    _streamSubscription?.cancel();
    _streamSubscription = Stream.fromFuture(_getAllAgents.call()).listen(
      (data) => value = AsyncState.success(data),
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
