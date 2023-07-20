import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartcityfeedbacksystem/models/engagement_model.dart';

class EngagementService {
  final CollectionReference _engagementsCollection =
      FirebaseFirestore.instance.collection('engagements');

Future<List<EngagementModel>> fetchCommentsByFeedbackId(String feedbackId) async {
  try {
    final querySnapshot = await _engagementsCollection
        .where('feedbackId', isEqualTo: feedbackId)
        .get();
    return querySnapshot.docs
        .map((doc) => EngagementModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('Error fetching comments: $e');
    return [];
  }
}


  Future<void> createComment(
      String feedbackId, String userId, String? commentText) async {
    try {
      if (commentText == null || commentText.isEmpty) {
        return;
      }

      final engagement = EngagementModel(
        feedbackId: feedbackId,
        userId: userId,
        commentText: commentText,
        liked: false,
        disliked: false,
      );

      await _engagementsCollection.doc(feedbackId).set(engagement.toMap());
    } catch (e) {
      print('Error creating comment: $e');
    }
  }

  Future<void> deleteComment(String feedbackId) async {
    try {
      await _engagementsCollection.doc(feedbackId).delete();
    } catch (e) {
      print('Error deleting comment: $e');
    }
  }
}
