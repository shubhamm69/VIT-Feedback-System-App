import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartcityfeedbacksystem/models/user_model.dart';

class UserService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot<Object?> docSnapshot =
          await _usersCollection.doc(userId).get();
      if (docSnapshot.exists) {
        return UserModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw e;
    }
  }

  Future<String?> getUsernameById(String? userId) async {
    try {
      if (userId == null) {
        return null;
      }

      final snapshot = await _usersCollection.doc(userId).get();
      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        return userData['username'] as String?;
      }
      return null;
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }
}
