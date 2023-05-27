import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Luxurious:
        return 'Luxurious';
      case Affordability.Pricey:
        return 'Pricey';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        // onTap: () {
        //   Get.bottomSheet(Container(
        //     color: Colors.transparent,
        //     child: Text('Hello'),
        //   ));
        // },
        child: Container(
            decoration: const BoxDecoration(boxShadow: []),
            height: 230,
            padding: const EdgeInsets.all(1),
            child: Stack(children: <Widget>[
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Container(
                    width: Get.width,
                    height: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 135),
                        Text(
                          title,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.timer,
                                    size: 15,
                                    color: Colors.blueGrey,
                                  ),
                                  const SizedBox(width: 2),
                                  Text('$duration minutes')
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.work,
                                    size: 15,
                                    color: Colors.brown,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(complexityText)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.currency_rupee,
                                    size: 15,
                                    color: Color.fromARGB(255, 228, 74, 125),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(affordabilityText)
                                ],
                              ),
                            ]),
                        //SizedBox(height: 7),
                      ],
                    )),
              ),
              Positioned(
                top: 5,
                left: 10,
                width: 308,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Hero(
                          tag: duration + 1,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ))),
                ),
              ),
            ])));
  }
}
