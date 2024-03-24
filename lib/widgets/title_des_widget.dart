import 'package:flutter/material.dart';

class TitleSubWidget extends StatelessWidget {
  TitleSubWidget(this.title, this.description);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          description,
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
