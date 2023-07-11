import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/feedback_model.dart';
import 'package:smartcityfeedbacksystem/services/feedback_services.dart';
import 'package:smartcityfeedbacksystem/services/user_services.dart';
class FeedbackViewScreen extends StatefulWidget {
  final String feedbackId;

  const FeedbackViewScreen({Key? key, required this.feedbackId})
      : super(key: key);

  @override
  _FeedbackViewScreenState createState() => _FeedbackViewScreenState();
}

class _FeedbackViewScreenState extends State<FeedbackViewScreen> {
  final feedbackService = FeedbackService();
  bool isLiked = false;
  bool isDisliked = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FeedbackModel?>(
      future: feedbackService.getFeedbackById(widget.feedbackId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Feedback Details'),
              backgroundColor: Colors.purple,
            ),
            body: const SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading Image...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          final FeedbackModel feedback = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Feedback Details'),
              backgroundColor: Colors.purple,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(feedback.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      feedback.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Problem Faced:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          feedback.problemFaced,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Category:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          feedback.category,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Severity:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${feedback.severity}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                              if (isDisliked) isDisliked = false;
                            });
                          },
                          icon: Icon(
                            isLiked
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                            color: isLiked ? Colors.blue : null,
                          ),
                        ),
                        Text(
                          '${feedback.upvotes}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isDisliked = !isDisliked;
                              if (isLiked) isLiked = false;
                            });
                          },
                          icon: Icon(
                            isDisliked
                                ? Icons.thumb_down_alt
                                : Icons.thumb_down_alt_outlined,
                            color: isDisliked ? Colors.red : null,
                          ),
                        ),
                        Text(
                          '${feedback.downvotes}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Comments:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: feedback.comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(feedback.comments[index].commentText),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Feedback Details'),
              backgroundColor: Colors.purple,
            ),
            body: const Center(child: Text('Feedback not found.')),
          );
        }
      },
    );
  }
}
