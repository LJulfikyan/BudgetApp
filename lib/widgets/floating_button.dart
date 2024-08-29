import 'package:flutter/material.dart';
import 'package:kyla_test/utilities.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton.large(
        onPressed: () {},
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.w(context)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w(context), top: 20.w(context)),
          child: const Icon(
            size: 50,
            Icons.menu_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
