import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../design_patterns/mediator/team_member.dart';

class NotificationList extends StatelessWidget {
  final List<TeamMember> members;
  final ValueSetter<TeamMember> onTap;

  const NotificationList({
    required this.members,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Last notifications',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: spaceM),
        Text(
          'Note: click on the card to send a notification from the team member.',
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(height: spaceS),
        for (final member in members)
          Card(
            margin: const EdgeInsets.symmetric(vertical: marginS),
            child: InkWell(
              onTap: () => onTap(member),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: paddingM,
                  horizontal: paddingL,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: spaceS),
                          Text(member.lastNotification ?? '-'),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: paddingL),
                      child: Icon(Icons.message),
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
