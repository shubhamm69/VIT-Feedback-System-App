import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/feedback_model.dart';
import 'package:smartcityfeedbacksystem/services/feedback_services.dart';

class FeedbackViewScreen extends StatefulWidget {
  final String feedbackId;

  const FeedbackViewScreen({Key? key, required this.feedbackId}) : super(key: key);

  @override
  _FeedbackViewScreenState createState() => _FeedbackViewScreenState();
}

class _FeedbackViewScreenState extends State<FeedbackViewScreen> {
  final feedbackService = FeedbackService();
  late FeedbackModel feedback;
  bool isLiked = false;
  bool isDisliked = false;

  @override
  void initState() {
    super.initState();
    // fetchFeedback();
  }

  // Future<void> fetchFeedback() async {
  //   feedback = await feedbackService.getFeedbackById(widget.feedbackId);
  //   if (feedback != null) {
  //     setState(() {
  //       isLiked = feedback.engagement?.liked ?? false;
  //       isDisliked = feedback.engagement?.disliked ?? false;
  //     });
  //   }
  // }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        isDisliked = false;
        feedback.upvotes++;
      } else {
        feedback.upvotes--;
      }
    });
    feedbackService.updateFeedback(feedback);
  }

  void toggleDislike() {
    setState(() {
      isDisliked = !isDisliked;
      if (isDisliked) {
        isLiked = false;
        feedback.downvotes++;
      } else {
        feedback.downvotes--;
      }
    });
    feedbackService.updateFeedback(feedback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Details'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<FeedbackModel?>(
        future: feedbackService.getFeedbackById(widget.feedbackId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
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
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            feedback = snapshot.data!;
            return Padding(
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
                    SizedBox(height: 16),
                    Text(
                      feedback.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
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
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
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
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
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
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          onPressed: toggleLike,
                          icon: Icon(
                            isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                            color: isLiked ? Colors.blue : null,
                          ),
                        ),
                        Text(
                          '${feedback.upvotes}',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: toggleDislike,
                          icon: Icon(
                            isDisliked ? Icons.thumb_down_alt : Icons.thumb_down_alt_outlined,
                            color: isDisliked ? Colors.red : null,
                          ),
                        ),
                        Text(
                          '${feedback.downvotes}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Comments:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('Feedback not found.'));
          }
        },
      ),
    );
  }
}
