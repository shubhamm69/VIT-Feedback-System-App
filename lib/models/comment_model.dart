class Comment {
  String userId;
  String commentText;

  Comment({
    required this.userId,
    required this.commentText,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'],
      commentText: map['commentText'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'commentText': commentText,
    };
  }
}
