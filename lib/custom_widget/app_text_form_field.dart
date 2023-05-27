// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  AppTextFormField(
      {super.key,
      required this.fieldController,
      required this.fielIcon,
      required this.fieldLabel,
      required this.fieldTextInputType,
      required this.fieldInputFormatters,
      this.fieldValidator,
      this.fieldOnChanged});

  TextEditingController fieldController;
  IconData fielIcon;
  String fieldLabel;
  TextInputType fieldTextInputType;
  List<TextInputFormatter> fieldInputFormatters;
  String? Function(String?)? fieldValidator;
  void Function(String)? fieldOnChanged;

  @override
  Widget build(BuildContext context) {
    return
        TextFormField(
      controller: fieldController,
      keyboardType: fieldTextInputType,
      inputFormatters: fieldInputFormatters,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(2.0),
          isDense: false,
          icon: Icon(fielIcon),
          label: Text(fieldLabel)),
      validator: fieldValidator,
      onChanged: fieldOnChanged,
    );
  }
}

// class AppTextFormFieldController extends GetxController {
//   var showCancel = false.obs;
// }
