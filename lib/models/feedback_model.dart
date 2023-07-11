
import 'package:smartcityfeedbacksystem/models/comment_model.dart';

class FeedbackModel {
  String id;
  String userId;
  String title;
  String problemFaced;
  String imagePath;
  int upvotes;
  int downvotes;
  int severity; // New field: Severity
  String category; // New field: Category
  List<Comment> comments;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.problemFaced,
    required this.imagePath,
    required this.upvotes,
    required this.downvotes,
    required this.severity, // Initialize severity
    required this.category, // Initialize category
    required this.comments,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      problemFaced: map['problemFaced'],
      imagePath: map['imagePath'],
      upvotes: map['upvotes'],
      downvotes: map['downvotes'],
      severity: map['severity'], // Assign severity from map
      category: map['category'], // Assign category from map
      comments: List<Comment>.from((map['comments'] ?? []).map((comment) => Comment.fromMap(comment))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'problemFaced': problemFaced,
      'imagePath': imagePath,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'severity': severity, // Add severity to the map
      'category': category, // Add category to the map
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }
}
