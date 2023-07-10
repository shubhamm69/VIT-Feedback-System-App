class FeedbackModel {
  String id;
  String userId;
  String title;
  String problemFaced;
  String imagePath;
  int likes;
  int dislikes;
  List<String> comments;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.problemFaced,
    required this.imagePath,
    this.likes = 0,
    this.dislikes = 0,
    List<String>? comments,
  }) : comments = comments ?? [];

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      problemFaced: map['problemFaced'],
      imagePath: map['imagePath'],
      likes: map['likes'] ?? 0,
      dislikes: map['dislikes'] ?? 0,
      comments: List<String>.from(map['comments'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'problemFaced': problemFaced,
      'imagePath': imagePath,
      'likes': likes,
      'dislikes': dislikes,
      'comments': comments,
    };
  }
}
