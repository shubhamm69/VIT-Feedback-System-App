import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/feedback_model.dart';
import 'package:smartcityfeedbacksystem/screens/search_screen.dart';
import 'package:smartcityfeedbacksystem/screens/addfeedback_screen.dart';
import 'package:smartcityfeedbacksystem/screens/viewfeedback_screen.dart';
import 'package:smartcityfeedbacksystem/services/services.dart';
import 'package:smartcityfeedbacksystem/widgets/feedback_card.dart';
import 'package:smartcityfeedbacksystem/widgets/custom_button.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _feedbackService = FeedbackService();

  final TextEditingController _searchController = TextEditingController();

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
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                filled: true,
                fillColor: Colors.purple.shade50,
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.purple,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
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
                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //   builder: (context) => SearchScreen(),
                    // ),
                    // );
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbackViewScreen(
                                  feedback: feedbacks[index],
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
