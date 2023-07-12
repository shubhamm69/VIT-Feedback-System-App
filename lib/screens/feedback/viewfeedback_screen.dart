import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/engagement_model.dart';
import 'package:smartcityfeedbacksystem/models/feedback_model.dart';
import 'package:smartcityfeedbacksystem/services/feedback_services.dart';
import 'package:smartcityfeedbacksystem/services/engagement_services.dart';
import 'package:smartcityfeedbacksystem/services/user_services.dart';
import 'package:smartcityfeedbacksystem/widgets/comment_card.dart';

class FeedbackViewScreen extends StatefulWidget {
  final String feedbackId;

  const FeedbackViewScreen({Key? key, required this.feedbackId})
      : super(key: key);

  @override
  _FeedbackViewScreenState createState() => _FeedbackViewScreenState();
}

class _FeedbackViewScreenState extends State<FeedbackViewScreen> {
  final feedbackService = FeedbackService();
  final engagementService = EngagementService();
  final userService = UserService(); // Create an instance of UserService

  late FeedbackModel feedback;
  bool isLiked = false;
  bool isDisliked = false;
  final TextEditingController _commentController = TextEditingController();
  List<EngagementModel> comments = [];

  @override
  void initState() {
    super.initState();
    fetchFeedback();
    fetchComments();
  }

  Future<void> fetchFeedback() async {
    feedback = (await feedbackService.getFeedbackById(widget.feedbackId))!;
    if (feedback != null) {
      setState(() {
        isLiked = feedback.engagement?.liked ?? false;
        isDisliked = feedback.engagement?.disliked ?? false;
      });
    }
  }

  Future<void> fetchComments() async {
    final fetchedComments =
        await engagementService.fetchComments(widget.feedbackId);
    if (fetchedComments != null) {
      setState(() {
        comments = fetchedComments as List<EngagementModel>;
      });
    }
  }

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

  void sendComment() async {
    String commentText = _commentController.text.trim();
    if (commentText.isEmpty) {
      return;
    }

    EngagementModel comment = EngagementModel(
      feedbackId: widget.feedbackId,
      userId: feedback.userId,
      commentText: commentText,
      liked: false,
      disliked: false,
    );

    await engagementService.createComment(
      widget.feedbackId,
      feedback.userId,
      commentText,
    );
    _commentController.clear();

    // Fetch the updated comment
    EngagementModel? updatedComment =
        await engagementService.fetchComments(widget.feedbackId);
    if (updatedComment != null) {
      setState(() {
        comments.add(updatedComment);
      });
    }
    print(updatedComment?.commentText);

    showCommentPostedDialog(); // Show the dialog after posting the comment
  }

  void showCommentPostedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comment Posted'),
          content: const Text('Your comment has been posted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                            isLiked
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
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
                            isDisliked
                                ? Icons.thumb_down_alt
                                : Icons.thumb_down_alt_outlined,
                            color: isDisliked ? Colors.red : null,
                          ),
                        ),
                        Text(
                          '${feedback.downvotes}',
                          style: TextStyle(fontSize: 16),
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
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return FutureBuilder<String?>(
                          future: userService.getUsernameById(comment
                              .userId), // Call the method on the instance
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              final username = snapshot.data!;
                              return CommentCard(
                                engagement: comment,
                                username: username,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text('Username not found');
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        labelText: 'Add a comment',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: sendComment,
                      child: const Text('Send'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Feedback not found.'));
          }
        },
      ),
    );
  }
}
