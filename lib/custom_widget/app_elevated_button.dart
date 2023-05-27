import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppElevatedButton extends StatelessWidget {
  AppElevatedButton({super.key, required this.buttonText, required this.buttonOnPressed});
  String buttonText;
  void Function() buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
        onPressed: () => buttonOnPressed(),
        child: Text(buttonText));
  }
}
