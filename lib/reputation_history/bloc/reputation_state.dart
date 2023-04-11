part of 'reputation_bloc.dart';

class ReputationState extends Equatable {
  final Status status;
  final List<Reputation> reputations;
  final int page;
  final bool hasReachMax;

  const ReputationState({
    this.status = Status.initial,
    this.reputations = const [],
    this.page = 1,
    this.hasReachMax = false,
  });

  ReputationState copyWith({
    Status? status,
    List<Reputation>? reputations,
    int? page,
    bool? hasReachMax,
  }) {
    return ReputationState(
      status: status ?? this.status,
      reputations: reputations ?? this.reputations,
      page: page ?? this.page,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object?> get props => [status, reputations, page, hasReachMax];
}
