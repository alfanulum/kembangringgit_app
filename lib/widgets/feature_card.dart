import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard(
      {Key? key, required this.route, required this.text, required this.image})
      : super(key: key);

  final String route;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
