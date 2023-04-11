import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_flutter_application/reputation_history/reputation_history.dart';
import 'package:demo_flutter_application/users/models/models.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ReputationsPage(accountId: user.accountId ?? 0),
        ));
      },
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        child: CachedNetworkImage(
          width: 50.0,
          height: 50.0,
          imageUrl: user.profileImage ?? '',
          fit: BoxFit.fill,
          placeholder: (context, url) => Container(
            color: Colors.grey,
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.red.shade400,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.displayName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text('Reputation: ${user.reputation}'),
          ],
        ),
      ),
      subtitle: Text('Location: ${user.location ?? 'Unknown'}'),
      dense: true,
    );
  }
}
