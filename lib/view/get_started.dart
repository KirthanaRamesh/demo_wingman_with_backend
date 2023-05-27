
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_style.dart';
import '../controller/get_started_controller.dart';
import '../custom_widget/initial_screen_skeleton.dart';
import '../custom_widget/app_elevated_button.dart';
import '../constants/app_paths.dart';

class GetStarted extends GetView<GetStartedController> {
  GetStarted({super.key});

  final GetStartedController _getStartedController =
      Get.put(GetStartedController());

  @override
  Widget build(BuildContext context) {
    return InitialScreenSkeleton(
      childrenWidgets: [
        Lottie.asset(AppPaths.getStarted, animate: true, repeat: false),
        const Text(
          'Get Started',
          textAlign: TextAlign.center,
          style: AppCustomStyle.pageHeading,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('We will text you a one-time password to your mobile number',
            textAlign: TextAlign.center, style: AppCustomStyle.pageContent),
        const SizedBox(
          height: 40,
        ),
        const Text('Enter Mobile Number',
            textAlign: TextAlign.center, style: AppCustomStyle.pageTextField),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Form(
            key: _getStartedController.phnNumberKey.value,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _getStartedController.phnFieldController.value,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length != 10) {
                  return 'Mobile number should be 10 digits';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        AppElevatedButton(
            buttonText: 'Get OTP',
            buttonOnPressed: () {
              _getStartedController.getOtp();
            }),
      ],
    );
  }
}
