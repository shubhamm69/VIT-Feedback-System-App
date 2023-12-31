import 'package:smartcityfeedbacksystem/models/engagement_model.dart';

class FeedbackModel {
  String feedbackId;
  String userId;
  String title;
  String problemFaced;
  String imagePath;
  int upvotes;
  int downvotes;
  int severity;
  String category;

  FeedbackModel({
    required this.feedbackId,
    required this.userId,
    required this.title,
    required this.problemFaced,
    required this.imagePath,
    required this.upvotes,
    required this.downvotes,
    required this.severity,
    required this.category,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      feedbackId: map['feedbackId'],
      userId: map['userId'],
      title: map['title'],
      problemFaced: map['problemFaced'],
      imagePath: map['imagePath'],
      upvotes: map['upvotes'],
      downvotes: map['downvotes'],
      severity: map['severity'],
      category: map['category'],);
  }

  get engagement => null;

  Map<String, dynamic> toMap() {
    return {
      'feedbackId': feedbackId,
      'userId': userId,
      'title': title,
      'problemFaced': problemFaced,
      'imagePath': imagePath,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'severity': severity,
      'category': category,
    };
  }
}
