import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/feedback_model.dart';

class FeedbackViewScreen extends StatelessWidget {
  final FeedbackModel feedback;

  const FeedbackViewScreen({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Details'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedback.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Problem Faced:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              feedback.problemFaced,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Upvotes: ${feedback.upvotes}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Downvotes: ${feedback.downvotes}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Comments:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: feedback.comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(feedback.comments[index].commentText),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
