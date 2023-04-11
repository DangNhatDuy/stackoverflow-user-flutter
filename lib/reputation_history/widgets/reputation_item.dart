import 'package:demo_flutter_application/reputation_history/models/models.dart';
import 'package:flutter/material.dart';

class ReputationItem extends StatelessWidget {
  final Reputation reputation;

  const ReputationItem({super.key, required this.reputation});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID ${reputation.postId}: ${reputation.reputationHistoryType ?? 'unknown'}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text('Change: ${reputation.reputationChange ?? 0}'),
          ],
        ),
      ),
      subtitle: Text('Created At: ${reputation.formattedDate}'),
      dense: true,
    );
  }
}
