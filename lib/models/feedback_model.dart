import 'package:smartcityfeedbacksystem/models/engagement_model.dart';

class FeedbackModel {
  String feedbackId;
  String userId;
  String title;
  String problemFaced;
  String imagePath;
  int upvotes;
  int downvotes;
  int severity; // New field: Severity
  String category; // New field: Category
  EngagementModel engagement;

  FeedbackModel({
    required this.feedbackId,
    required this.userId,
    required this.title,
    required this.problemFaced,
    required this.imagePath,
    required this.upvotes,
    required this.downvotes,
    required this.severity, // Initialize severity
    required this.category, // Initialize category
    EngagementModel? engagement, // Change List<EngagementModel>? to EngagementModel?
  }) : engagement = engagement ?? EngagementModel(); // Initialize engagement with a new instance if null

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      feedbackId: map['feedbackId'],
      userId: map['userId'],
      title: map['title'],
      problemFaced: map['problemFaced'],
      imagePath: map['imagePath'],
      upvotes: map['upvotes'],
      downvotes: map['downvotes'],
      severity: map['severity'], // Assign severity from map
      category: map['category'], // Assign category from map
      engagement: EngagementModel.fromMap(map['engagement'] ?? {}), // Initialize engagement from map
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'feedbackId': feedbackId,
      'userId': userId,
      'title': title,
      'problemFaced': problemFaced,
      'imagePath': imagePath,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'severity': severity, // Add severity to the map
      'category': category, // Add category to the map
      'engagement': engagement.toMap(), // Add engagement to the map
    };
  }
}
