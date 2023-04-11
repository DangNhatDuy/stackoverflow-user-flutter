import 'package:demo_flutter_application/users/models/user.dart';

class UserResponse {
  List<User>? data;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  UserResponse({
    this.data,
    this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  UserResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      data = <User>[];
      json['items'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['items'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['quota_max'] = quotaMax;
    data['quota_remaining'] = quotaRemaining;
    return data;
  }
}
