// import 'package:flutter/material.dart';

// class FeedbackCard extends StatelessWidget {
//   final UserFeedback feedback;
//   final String limitedDescription;

//   const FeedbackCard({required this.feedback, required this.limitedDescription});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => FeedbackDetailsScreen(feedback: feedback),
//           ),
//         );
//       },
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 feedback.title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 limitedDescription,
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
