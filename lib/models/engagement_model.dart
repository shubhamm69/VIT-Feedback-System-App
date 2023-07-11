class EngagementModel {
  String? userId;
  String? commentText;
  bool liked;
  bool disliked;

  EngagementModel({
    this.userId,
    this.commentText,
    this.liked = false,
    this.disliked = false,
  });

  factory EngagementModel.fromMap(Map<String, dynamic> map) {
    return EngagementModel(
      userId: map['userId'],
      commentText: map['commentText'],
      liked: map['liked'] ?? false,
      disliked: map['disliked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'commentText': commentText,
      'liked': liked,
      'disliked': disliked,
    };
  }
}
