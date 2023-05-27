
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/app_paths.dart';import '../constants/app_sec_storage.dart';
import '../controller/get_started_controller.dart';
import '../model/otp_verification_response.dart';
import 'package:flutter/material.dart';

class EnterOTPController extends GetxController {
  final GetStartedController _getStartedController =
      Get.find<GetStartedController>();
  var otpFieldController = TextEditingController().obs;
  Rx<OtpVerificationResponse> responseData =
      OtpVerificationResponse(status: false, profileExists: false, jwt: '').obs;

  verifyOtp() async {
    await http.post(Uri.parse('${AppPaths.url}verifyotp.php'), body: {
      "request_id": _getStartedController.responseData.value.requestId,
      "code": otpFieldController.value.text
    }).then((data) {
      AppSecureStorage().deleteValue(AppPaths.jwtKey);
      responseData.value = otpVerificationResponseFromJson(data.body);
      responseData.refresh();
      AppSecureStorage().writeData(AppPaths.jwtKey, responseData.value.jwt);
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
