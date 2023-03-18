import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScoreWidget extends StatelessWidget {
  final Color bgColor;
  final int score;
  final TextStyle? textStyle;
  const ScoreWidget(
      {super.key, required this.bgColor, required this.score, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: bgColor),
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 2.0,
      ),
      child: Text(
        score.toString(),
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }
}
