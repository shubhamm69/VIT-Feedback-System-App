import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/engagement_model.dart';

class CommentCard extends StatelessWidget {
  final EngagementModel engagement;
  final String username;

  const CommentCard({
    Key? key,
    required this.engagement,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              engagement.userId ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              engagement.commentText ?? '',
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
