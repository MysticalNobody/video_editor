import 'package:flutter/widgets.dart';

const Color blackColor = Color(0xFF000000);
const Color whiteColor = Color(0xFFFFFFFF);

///#1ca385
const Color greenColor = Color(0xFF4CAF50);

///#30bcd0
const Color lightBlueColor = Color(0xFF30bcd0);

///#2196F3
const Color blueColor = Color(0xFF2196F3);

///#11161c
const Color almostBlackColor = Color(0xFF11161c);

///#657080
const Color darkGreyColor = Color(0xFF657080);

///#9daabd
const Color greyColor = Color(0xFF9daabd);

///#ececec
const Color lightGreyColor = Color(0xFFececec);

///#f4f6f8
const Color almostWhiteColor = Color(0xFFf4f6f8);

///#eecbdf
const Color pinkColor = Color(0xFFeecbdf);

///#4f00c0
const Color violetColor = Color(0xFF4f00c0);

///#bb00ab
const Color purpureColor = Color(0xFF4A148C);

///#e0023c
const Color cherryColor = Color(0xFFe0023c);

///#ff2500
const Color redColor = Color(0xFFff2500);

const double smallSize = 10;
const double normalSize = 14;
const double bigSize = 18;

const FontWeight lightWeight = FontWeight.w300;
const FontWeight normalWeight = FontWeight.normal;
const FontWeight boldWeight = FontWeight.bold;

TextStyle genTextStyle([
  Color color = blackColor,
  double size = normalSize,
  FontWeight weight = normalWeight,
]) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: weight,
  );
}
