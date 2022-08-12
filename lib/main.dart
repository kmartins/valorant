import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant/agents/domain/repositories/agent_repository.dart';
import 'package:valorant/agents/domain/usecases/get_all_agents.dart';
import 'package:valorant/agents/external/datasources/agent_local_data_source_impl.dart';
import 'package:valorant/agents/external/datasources/agent_network_data_source_impl.dart';
import 'package:valorant/agents/infra/datasourcers/agent_local_data_source.dart';
import 'package:valorant/agents/infra/datasourcers/agent_network_data_source.dart';
import 'package:valorant/agents/infra/repositories/agent_repository_impl.dart';
import 'package:valorant/agents/presenter/agents_view_model.dart';
import 'package:valorant/app_widget.dart';
import 'package:valorant/core/services/http_adapter.dart';
import 'package:valorant/core/services/http_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection();
  runApp(const AppWidget());
}

Future<void> injection() async {
  final getIt = GetIt.instance;
  getIt
    ..registerLazySingletonAsync<SharedPreferences>(
      SharedPreferences.getInstance,
    )
    ..registerLazySingleton<HttpAdapter>(
      () => HttpService(Client()),
    )
    ..registerLazySingleton<AgentNetworkDataSource>(
      () => AgentNetworkDataSourceImpl(getIt.get()),
    )
    ..registerLazySingleton<AgentLocalDataSource>(
      () => AgentLocalDataSourceImpl(getIt.get()),
    )
    ..registerLazySingleton<AgentRepository>(
      () => AgentRepositoryImpl(getIt.get(), getIt.get()),
    )
    ..registerLazySingleton<GetAllAgents>(
      () => GetAllAgents(getIt.get()),
    )
    ..registerLazySingleton<AgentsViewModel>(
      () => AgentsViewModel(getIt.get()),
    );
  return getIt.isReady<SharedPreferences>();
}
