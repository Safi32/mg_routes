import 'package:flutter/material.dart';
import 'package:mg_routes/utils/colors.dart';

class ProgressIndicatorExample extends StatefulWidget {
  final percentage;
  ProgressIndicatorExample(this.percentage);

  @override
  State<ProgressIndicatorExample> createState() =>
      _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 2.5,
          width: 325,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Container(
          height: 2.5,
          width: (widget.percentage / 100) * 310,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
                shape: BoxShape.circle, gradient: reverselinearGradient),
          ),
        ),
        Positioned(
          left: size.width - 95,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ),
        Positioned(
          left: (widget.percentage / 100) * 310,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
                shape: BoxShape.circle, gradient: reverselinearGradient),
          ),
        ),
      ],
    );
  }
}
