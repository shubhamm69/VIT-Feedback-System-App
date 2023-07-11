import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/feedback_model.dart';
import 'package:smartcityfeedbacksystem/screens/search/search_screen.dart';
import 'package:smartcityfeedbacksystem/screens/feedback/addfeedback_screen.dart';
import 'package:smartcityfeedbacksystem/screens/feedback/viewfeedback_screen.dart';
import 'package:smartcityfeedbacksystem/services/feedback_services.dart';
import 'package:smartcityfeedbacksystem/widgets/feedback_card.dart';
import 'package:smartcityfeedbacksystem/widgets/custom_button.dart';
import 'package:smartcityfeedbacksystem/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _feedbackService = FeedbackService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIT Feedback'),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: searchBar(),
          ),
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Image.asset(
                  'assets/campus-banner.jpg',
                  fit: BoxFit.cover,
                  width: 400,
                  height: 200,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Feedbacks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: StreamBuilder<List<FeedbackModel>>(
                stream: _feedbackService.getAllUserFeedbacksStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<FeedbackModel> feedbacks = snapshot.data!;
                    return ListView.builder(
                      itemCount: feedbacks.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbackViewScreen(
                                  feedbackId: feedbacks[index].feedbackId,
                                ),
                              ),
                            );
                          },
                          child: FeedbackCard(
                            feedback: feedbacks[index],
                            limitedDescription: feedbacks[index].problemFaced,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: CustomButton(
        text: '+ Add Feedback',
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
