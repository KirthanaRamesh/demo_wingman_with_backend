

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/app_paths.dart';
import '../constants/app_style.dart';
import '../constants/dummy_food_data.dart';
import '../model/meal.dart';

class AppHomeController extends GetxController {
  var defaultChioceChipIndex = 0.obs;
  var mealMenu = <Meal>[].obs;

  var scrollViewController = ScrollController().obs;
  var showAppbar = true.obs;
  var isScrollingDown = false.obs;

  changeCurrentItem(index) {
    defaultChioceChipIndex.value = index;
    mealMenu.clear();
    mealMenu.addAll(DummyFoodData.dummyMeals.where((meal) {
      return meal.categories.contains(
          DummyFoodData.dummyCategories[defaultChioceChipIndex.value].id);
    }).toList());
    mealMenu.refresh();
    mealMenu;
  }

  showExit(context) {
    Get.bottomSheet(Container(
        padding: const EdgeInsets.only(
            bottom: 20, left: 20, right: 20, top: 5), //all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 3,
                width: 40,
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(58, 158, 158, 158),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text('   ')),
              ),
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  AppPaths.exit,
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Exit App?',
                  style: AppCustomStyle.pageHeading,
                )
              ],
            ),
            const Flexible(
              child: Text(
                'Are you sure, you want to exit the mobile app?',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'No',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    SystemNavigator.pop();
                    Navigator.of(context).pop(true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        )));
    //return true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeCurrentItem(0);
    scrollViewController.value.addListener(() {
      if (scrollViewController.value.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown.value) {
          isScrollingDown.value = true;
          showAppbar.value = false;
        }
      }
      if (scrollViewController.value.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown.isTrue) {
          isScrollingDown.value = false;
          showAppbar.value = true;
        }
      }
    });
  }
}
