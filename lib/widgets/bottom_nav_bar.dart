import 'package:flutter/material.dart';
import 'package:kyla_test/utilities.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height * 0.1,
      color: const Color(0xFF091234),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 30.w(context),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_outlined,
              color: Colors.white,
              size: 30.w(context),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 30.w(context),
            ),
          ),
        ],
      ),
    );
  }
}
