import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeRow extends StatelessWidget {
  TimeRow({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  String title;
  String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, scale: 8),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: 3),
            Text(
              subTitle,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
