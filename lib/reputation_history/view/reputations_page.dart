import 'package:demo_flutter_application/reputation_history/bloc/reputation_bloc.dart';
import 'package:demo_flutter_application/reputation_history/view/reputations_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ReputationsPage extends StatelessWidget {
  final int accountId;

  const ReputationsPage({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reputations'),
      ),
      body: BlocProvider(
        create: (_) =>
            ReputationBloc(httpClient: http.Client(), accountId: accountId)
              ..add(ReputationFetched()),
        child: const ReputationsList(),
      ),
    );
  }
}
