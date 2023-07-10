import 'package:smartcityfeedbacksystem/models/feedback_model.dart';

class UserModel {
  String name;
  String email;
  String bio;
  String regno;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;
  List<FeedbackModel> feedbacks;

  UserModel({
    required this.name,
    required this.email,
    required this.bio,
    required this.regno,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    List<FeedbackModel>? feedbacks,
  }) : feedbacks = feedbacks ?? [];

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      bio: map['bio'],
      regno: map['regno'],
      profilePic: map['profilePic'],
      createdAt: map['createdAt'],
      phoneNumber: map['phoneNumber'],
      uid: map['uid'],
      feedbacks: List<FeedbackModel>.from(
        (map['feedbacks'] ?? []).map((feedback) => FeedbackModel.fromMap(feedback)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'bio': bio,
      'regno': regno,
      'profilePic': profilePic,
      'createdAt': createdAt,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'feedbacks': feedbacks.map((feedback) => feedback.toMap()).toList(),
    };
  }
}
