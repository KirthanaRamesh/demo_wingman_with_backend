
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dummy_food_data.dart';
import '../controller/app_home_controller.dart';

// ignore: must_be_immutable
class MealMenu extends StatelessWidget {
  MealMenu({super.key, required this.categoryId});
  String categoryId;

  final AppHomeController _appHomeController = Get.find<AppHomeController>();

  @override
  Widget build(BuildContext context) {
    for (int index = 0; index < DummyFoodData.dummyMeals.length; index++) {
      categoryId == DummyFoodData.dummyMeals[index].id
          ? _appHomeController.mealMenu.add(DummyFoodData.dummyMeals[index])
          : null;
    }
    return const Placeholder();
  }
}
