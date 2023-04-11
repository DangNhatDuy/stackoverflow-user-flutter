import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:demo_flutter_application/reputation_history/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:http/http.dart' as http;

import '../../users/users.dart';

part 'reputation_event.dart';
part 'reputation_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ReputationBloc extends Bloc<ReputationEvent, ReputationState> {
  ReputationBloc({required this.httpClient, required this.accountId})
      : super(const ReputationState()) {
    on<ReputationFetched>(
      _onReputationFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  final http.Client httpClient;
  final int accountId;

  Future<void> _onReputationFetched(
      ReputationFetched event, Emitter<ReputationState> emit) async {
    if (state.hasReachMax) return;
    try {
      if (state.status == Status.initial) {
        final reputations = await _fetchReputations(state.page, accountId);
        emit(state.copyWith(
          status: Status.success,
          reputations: reputations,
          page: state.page + 1,
          hasReachMax: false,
        ));
      }

      final reputations = await _fetchReputations(state.page, accountId);
      reputations.isEmpty
          ? emit(state.copyWith(hasReachMax: true))
          : emit(
              state.copyWith(
                status: Status.success,
                reputations: List.of(state.reputations)..addAll(reputations),
                page: state.page + 1,
                hasReachMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<List<Reputation>> _fetchReputations(int page, int accountId) async {
    final response = await httpClient.get(
      Uri.https(
        'api.stackexchange.com',
        '/2.2/users/$accountId/reputation-history',
        <String, String>{
          'page': '$page',
          'size': '30',
          'site': 'stackoverflow'
        },
      ),
      headers: {
        "Accept": "application/json;charset=utf-8",
        "Accept-Language": "en"
      },
    );

    if (response.statusCode == 200) {
      final reputationResponse =
          ReputationResponse.fromJson(json.decode(response.body));
      return reputationResponse.items ?? [];
    }
    throw Exception('error fetching reputations');
  }
}
