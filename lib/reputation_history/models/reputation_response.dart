import 'package:demo_flutter_application/reputation_history/models/reputation.dart';

class ReputationResponse {
  List<Reputation>? items;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  ReputationResponse(
      {this.items, this.hasMore, this.quotaMax, this.quotaRemaining});

  ReputationResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Reputation>[];
      json['items'].forEach((v) {
        items!.add(Reputation.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['quota_max'] = quotaMax;
    data['quota_remaining'] = quotaRemaining;
    return data;
  }
}
