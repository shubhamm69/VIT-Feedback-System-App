
import 'package:smartcityfeedbacksystem/models/comment_model.dart';

class FeedbackModel {
  String id;
  String userId;
  String title;
  String problemFaced;
  String imagePath;
  int upvotes;
  int downvotes;
  List<Comment> comments;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.problemFaced,
    required this.imagePath,
    required this.upvotes,
    required this.downvotes,
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
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }
}
