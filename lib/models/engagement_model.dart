class EngagementModel {
  String? feedbackId;
  String? userId;
  String? commentText;
  bool liked;
  bool disliked;

  EngagementModel({
    required feedbackId,
    this.userId,
    this.commentText,
    this.liked = false,
    this.disliked = false,
  });
  factory EngagementModel.fromMap(Map<String, dynamic> map) {
    return EngagementModel(
      feedbackId: map['feedbackId'],
      userId: map['userId'],
      commentText: map['commentText'],
      liked: map['liked'] ?? false,
      disliked: map['disliked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'feedbackId': feedbackId,
      'userId': userId,
      'commentText': commentText,
      'liked': liked,
      'disliked': disliked,
    };
  }
}
