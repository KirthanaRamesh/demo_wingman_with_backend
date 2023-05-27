import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_style.dart';
import '../controller/welcome_controller.dart';
import '../custom_widget/app_elevated_button.dart';
import '../constants/app_paths.dart';
import '../constants/app_strings.dart';

class Welcome extends GetView<WelcomeController> {
  Welcome({super.key});

  final WelcomeController _welcomeController = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
                clipper: MyClipper(),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 0, right: 10),
                  height: 275,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).colorScheme.secondaryContainer,
                        Theme.of(context).colorScheme.primaryContainer,
                      ],
                    ),
                    image: const DecorationImage(
                      image: AssetImage(AppPaths.stars),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 10,
                              left: 115,
                              child: SvgPicture.asset(
                                AppPaths.welcomelogo,
                                width: 270,
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.bottomLeft,
                              ),
                            ),
                            const Positioned(
                              top: 80,
                              left: 15,
                              child: Text(
                                'We are ready to work\ntogether to get you\nto your goal!',
                                textAlign: TextAlign.left,
                                style: AppCustomStyle.pageContent,
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Welcome!',
                              textAlign: TextAlign.center,
                              style: AppCustomStyle.pageHeading,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'We are delighted that you are here! Let us know something about you',
                              textAlign: TextAlign.center,
                              style: AppCustomStyle.pageContent,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Obx(
                              () => Form(
                                key: _welcomeController.welcomeFormKey.value,
                                child: Column(children: [
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _welcomeController
                                        .nameFieldController.value,
                                    keyboardType: TextInputType.name,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z ]"))
                                    ],
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(2.0),
                                        isDense: false,
                                        icon: Icon(
                                          Icons.person_4_outlined,
                                        ),
                                        label: Text('Name')),
                                    onChanged: (val) {
                                      _welcomeController
                                          .welcomeFormKey.value.currentState
                                          ?.validate();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      } else if (value.length < 3) {
                                        return 'Name must be minimum 3 characters';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    autovalidateMode: 
                                    AutovalidateMode.onUserInteraction,
                                    controller: _welcomeController
                                        .emailFieldController.value,
                                    keyboardType: TextInputType.emailAddress,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[A-Za-z0-9#+-.@_]*"))
                                    ],
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(2.0),
                                        isDense: false,
                                        icon: Icon(
                                          Icons.mail_outline,
                                        ),
                                        label: Text('Email')),
                                    onChanged: (val) {
                                      _welcomeController
                                          .welcomeFormKey.value.currentState
                                          ?.validate();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter email";
                                      } else if (!RegExp(r'\S+@\S+\.\S+')
                                          .hasMatch(value)) {
                                        return "Please enter a valid email format";
                                      }
                                      return null;
                                    },
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            AppElevatedButton(
                                buttonText: 'Submit',
                                buttonOnPressed: () {
                                  if (_welcomeController.nameFieldController
                                          .value.text.isNotEmpty &&
                                      _welcomeController.emailFieldController
                                          .value.text.isNotEmpty) {
                                    _welcomeController.profileSubmit();
                                    Get.offAllNamed(AppString.appHomeRoute);
                                  }
                                }),
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
