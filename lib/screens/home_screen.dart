import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/feedback_model.dart';
import 'package:smartcityfeedbacksystem/screens/addfeedback_screen.dart';
import 'package:smartcityfeedbacksystem/services/services.dart';
import 'package:smartcityfeedbacksystem/widgets/feedback_card.dart';
import 'package:smartcityfeedbacksystem/widgets/custom_button.dart';

class HomePage extends StatelessWidget {

  final FeedbackService _feedbackService = FeedbackService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedbacks'),
        backgroundColor: Colors.purple,
      ),
      body: StreamBuilder<List<FeedbackModel>>(
        stream: _feedbackService.getAllUserFeedbacksStream(), // Replace 'userId' with the actual user ID
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<FeedbackModel> feedbacks = snapshot.data!;
            return ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                return FeedbackCard(
                  feedback: feedbacks[index],
                  limitedDescription: feedbacks[index].problemFaced,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: CustomButton(
        text: 'Add Feedback',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFeedbackScreen(),
            ),
          );
        },
      ),
    );
  }
}
