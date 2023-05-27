
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../custom_widget/initial_screen_skeleton.dart';
import '../constants/app_style.dart';
import '../constants/app_paths.dart';
import '../constants/app_strings.dart';
import '../controller/enter_otp_controller.dart';
import '../controller/get_started_controller.dart';
import '../custom_widget/app_elevated_button.dart';

class EnterOTP extends GetView<EnterOTPController> {
  EnterOTP({super.key});

  final EnterOTPController _enterOTPController = Get.put(EnterOTPController());
  final GetStartedController _getStartedController =
      Get.find<GetStartedController>();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: const Color.fromRGBO(23, 171, 144, 0.4)),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child:
          Obx(() => _getStartedController.responseData.value.requestId.isEmpty
              ? const Scaffold(body: Center(child: CircularProgressIndicator()))
              : InitialScreenSkeleton(childrenWidgets: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 30),
                    child: Image.asset(
                      AppPaths.verifyOtp,
                    ),
                  ),
                  const Text(
                    'OTP Validation',
                    textAlign: TextAlign.center,
                    style: AppCustomStyle.pageHeading,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Enter the OTP sent to ${_getStartedController.phnFieldController.value.text}',
                    textAlign: TextAlign.center,
                    style: AppCustomStyle.pageContent,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Pinput(
                    length: 6,
                    controller: _enterOTPController.otpFieldController.value,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    obscureText: true,
                    useNativeKeyboard: true,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Didn\'t get an OTP yet? ',
                        style: AppCustomStyle.pageTextField,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          'Resend OTP',
                          style: AppCustomStyle.clickableText,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  AppElevatedButton(
                      buttonText: 'Validate',
                      buttonOnPressed: () {
                        if (_enterOTPController
                                .otpFieldController.value.text.length ==
                            6) {
                          Get.offAllNamed(AppString.welcomeRoute);
                          _enterOTPController.verifyOtp();
                        }
                      })
                ])),
    );
  }
}
