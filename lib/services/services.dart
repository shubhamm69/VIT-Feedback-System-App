import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smartcityfeedbacksystem/models/feedback_model.dart';

class FeedbackService {
  final CollectionReference _feedbacksCollection =
      FirebaseFirestore.instance.collection('feedbacks');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> createFeedback(FeedbackModel feedback) async {
    try {
      DocumentReference docRef =
          await _feedbacksCollection.add(feedback.toMap());
      return docRef.id;
    } catch (e) {
      throw e;
    }
  }

  Future<FeedbackModel?> getFeedbackById(String feedbackId) async {
    try {
      DocumentSnapshot<Object?> docSnapshot =
          await _feedbacksCollection.doc(feedbackId).get();
      if (docSnapshot.exists) {
        return FeedbackModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw e;
    }
  }

  Stream<List<FeedbackModel>> getUserFeedbacksStream(String userId) {
    try {
      return _feedbacksCollection
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) =>
                  FeedbackModel.fromMap(doc.data()! as Map<String, dynamic>))
              .toList());
    } catch (e) {
      throw e;
    }
  }

  Stream<List<FeedbackModel>> getAllUserFeedbacksStream() {
    try {
      return _feedbacksCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs
              .map((doc) =>
                  FeedbackModel.fromMap(doc.data()! as Map<String, dynamic>))
              .toList());
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateFeedback(FeedbackModel feedback) async {
    try {
      await _feedbacksCollection.doc(feedback.id).update(feedback.toMap());
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteFeedback(String feedbackId) async {
    try {
      await _feedbacksCollection.doc(feedbackId).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<String> storeImage(String feedbackId, File image) async {
    try {
      String imagePath =
          'feedbacks/$feedbackId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _storage.ref(imagePath).putFile(image);

      String downloadURL = await _storage.ref(imagePath).getDownloadURL();

      return downloadURL;
    } catch (e) {
      throw e;
    }
  }
}
