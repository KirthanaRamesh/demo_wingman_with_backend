
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/app_home_controller.dart';
import '../constants/dummy_food_data.dart';
import '../custom_widget/meal_item.dart';
import '../constants/app_paths.dart';

class AppHome extends GetView<AppHomeController> {
  AppHome({super.key});

  final AppHomeController _appHomeController = Get.put(AppHomeController());
  @override
  Widget build(BuildContext context) {
    Widget chip(String label, Color color, index) {
      return Obx(
        () => ChoiceChip(
          backgroundColor: Colors.white,
          selectedColor: Theme.of(context).colorScheme.primary,
          shape: const StadiumBorder(),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      _appHomeController.defaultChioceChipIndex.value == index
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary),
            ),
          ),
          selected: _appHomeController.defaultChioceChipIndex.value == index,
          onSelected: (selected) {
            _appHomeController.changeCurrentItem(index);
          },
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return _appHomeController.showExit(context);
        //true;
      },
      child: SafeArea(
        child: Obx(
          () => Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AnimatedContainer(
                height: _appHomeController.showAppbar.isTrue ? 56.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: AppBar(
                  backgroundColor: const Color.fromARGB(121, 230, 191, 230),
                  title: Column(
                    children: [
                      const Text(''),
                      Text(
                        'Hello Hooman!',
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(''),
                    ],
                  ),
                  centerTitle: true,
                  actions: [
                    Lottie.asset(AppPaths.profile, repeat: false, animate: true)
                  ],
                ),
              ),
            ),
            body: Container(
              height: Get.height,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: const Color.fromARGB(
                  121, 230, 191, 230), //Color.fromARGB(95, 229, 198, 233),
              child: SingleChildScrollView(
                controller: _appHomeController.scrollViewController.value,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What would you like to cook?',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 50, //0.128,
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 1,
                          childAspectRatio: 0.5,
                          mainAxisSpacing: 0.0,
                          children: List.generate(
                              DummyFoodData.dummyCategories.length, (index) {
                            return Center(
                                child: chip(
                                    DummyFoodData.dummyCategories[index].title,
                                    DummyFoodData.dummyCategories[index].color,
                                    index));
                          }),
                        ),
                      ),
                      Obx(
                        () => Column(
                            children: List.generate(
                                _appHomeController.mealMenu.length, (j) {
                          return MealItem(
                              id: _appHomeController.mealMenu[j].id,
                              title: _appHomeController.mealMenu[j].title,
                              imageUrl: _appHomeController.mealMenu[j].imageUrl,
                              duration: _appHomeController.mealMenu[j].duration,
                              complexity:
                                  _appHomeController.mealMenu[j].complexity,
                              affordability:
                                  _appHomeController.mealMenu[j].affordability);
                        })),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
