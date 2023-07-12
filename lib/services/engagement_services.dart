import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartcityfeedbacksystem/models/engagement_model.dart';

class EngagementService {
  final CollectionReference _engagementsCollection =
      FirebaseFirestore.instance.collection('engagements');

  Future<EngagementModel?> fetchComments(String feedbackId) async {
    try {
      final snapshot = await _engagementsCollection.doc(feedbackId).get();
      if (snapshot.exists) {
        return EngagementModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error fetching engagement: $e');
      return null;
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
