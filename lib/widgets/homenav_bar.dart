import 'package:flutter/material.dart';

class homeAppBar extends StatelessWidget {
  final String title;
  final ImageProvider userProfileImage;
  final VoidCallback onTapUserProfile;

  const homeAppBar({
    required this.title,
    required this.userProfileImage,
    required this.onTapUserProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  top: 34.0,
                  bottom: 32.0,
                  right: 32.0
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: onTapUserProfile,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 24.0,
                    
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: userProfileImage,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
