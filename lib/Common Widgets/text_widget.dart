import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final Color? decorationColor;
  final String? fontFamily;
  final double? fontSize;
  final double? decorationThickness;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final int? maxLines;
  final double? height;
  final List<Shadow>? shadows;
  const TextWidget(
      {Key? key,
      required this.text,
      this.textAlign,
      this.color = AppColors.black,
      this.fontFamily,
      this.fontSize,
      this.overflow,
      this.fontWeight,
      this.decoration,
      this.maxLines,
      this.height,
      this.decorationColor,
      this.decorationThickness,
      this.shadows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        height: height,
        decoration: decoration,
        fontFamily: fontFamily,
        overflow: overflow,
        fontSize: fontSize,
        shadows: shadows,
        fontWeight: fontWeight,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      ),
    );
  }
}
