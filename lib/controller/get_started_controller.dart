
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../constants/app_strings.dart';
import '../model/get_otp.dart';

class GetStartedController extends GetxController {
  final phnNumberKey = GlobalKey<FormState>().obs;
  var phnFieldController = TextEditingController().obs;

  Rx<GetOtpResponse> responseData =
      GetOtpResponse(status: false, response: '', requestId: '').obs;

  getOtp() async {
    if (phnNumberKey.value.currentState!.validate()) {
      Get.toNamed(AppString.enterOtpRoute);
      await http.post(Uri.parse('https://test-otp-api.7474224.xyz/sendotp.php'),
        body: {'mobile': phnFieldController.value.text}).then((data) {
      responseData.value = getOtpResponseFromJson(data.body);
    });
    } else {
    }
  }
}
