import 'package:intl/intl.dart';

class Reputation {
  String? reputationHistoryType;
  int? reputationChange;
  int? postId;
  int? creationDate;
  int? userId;

  Reputation(
      {this.reputationHistoryType,
      this.reputationChange,
      this.postId,
      this.creationDate,
      this.userId});

  String get formattedDate => DateFormat('yyyy-MM-dd HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch((creationDate ?? 0) * 1000));

  Reputation.fromJson(Map<String, dynamic> json) {
    reputationHistoryType = json['reputation_history_type'];
    reputationChange = json['reputation_change'];
    postId = json['post_id'];
    creationDate = json['creation_date'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reputation_history_type'] = reputationHistoryType;
    data['reputation_change'] = reputationChange;
    data['post_id'] = postId;
    data['creation_date'] = creationDate;
    data['user_id'] = userId;
    return data;
  }
}
