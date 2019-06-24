import 'package:flutter/material.dart';
import 'package:hack_mobile/styles.dart';

class LogoText extends StatelessWidget {
  final double widthFactor;
  final double heightFactor;
  LogoText([this.widthFactor = 0.7, this.heightFactor = 0.07]);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * widthFactor,
      height: size.height * heightFactor,
      child: FittedBox(
        alignment: Alignment.center,
        child: Text(
          "Видео редактор",
          textAlign: TextAlign.center,
          style: genTextStyle(blackColor, 16, boldWeight),
        ),
      ),
    );
  }
}
