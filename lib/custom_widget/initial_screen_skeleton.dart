import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InitialScreenSkeleton extends StatelessWidget {
  InitialScreenSkeleton({super.key, required this.childrenWidgets});
  List<Widget> childrenWidgets;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: childrenWidgets,
            ),
          ),
        ),
      ),
    );
  }
}
