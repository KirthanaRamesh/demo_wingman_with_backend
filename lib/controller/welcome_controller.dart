
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/app_paths.dart';
import '../constants/app_sec_storage.dart';
import '../model/profile_submit_response.dart';

class WelcomeController extends GetxController {
  final welcomeFormKey = GlobalKey<FormState>().obs;
  var nameFieldController = TextEditingController().obs;
  var emailFieldController = TextEditingController().obs;
  Rx<ProfileSubmitResponse> responseData =
      ProfileSubmitResponse(status: false, response: '').obs;

  profileSubmit() async {
    // ignore: unused_local_variable
    var hasJwt = await AppSecureStorage()
        .containsKey(AppPaths.jwtKey)
        .then((value) async {
      if (value == true) {
        var jwt = await AppSecureStorage().readData(AppPaths.jwtKey);
        await http.post(Uri.parse('${AppPaths.url}profilesubmit.php'),
            headers: {
              'Token': jwt
            },
            body: {
              "name": nameFieldController.value.text,
              "email": emailFieldController.value.text
            }).then((data) {
          AppSecureStorage().deleteValue(AppPaths.nameKey);
          responseData.value = profileSubmitResponseFromJson(data.body);
          responseData.value.status == true
              ? AppSecureStorage()
                  .writeData(AppPaths.nameKey, nameFieldController.value.text)
              : AppSecureStorage().deleteValue(AppPaths.nameKey);
          responseData.refresh();
        });
      }
    });
  }
}
