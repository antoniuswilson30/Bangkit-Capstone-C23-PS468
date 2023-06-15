import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double fontSize;
  final Color textColor = Color(0xFF05729D);

  TopBar({required this.title, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      toolbarHeight: 64,
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xFF333333),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
