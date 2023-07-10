import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showProfileIcon;

  const MyAppBar({
    required this.title,
    this.showProfileIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: showProfileIcon ? _buildActions(context) : null,
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.person),
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
    ];
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
