import 'package:flutter/material.dart';
import 'package:valorant/agents/presenter/agents_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valorant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF101823),
        appBarTheme: const AppBarTheme(color: Colors.black),
      ),
      home: const AgentsPage(),
    );
  }
}
