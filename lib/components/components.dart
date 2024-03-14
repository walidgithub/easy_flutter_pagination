import 'package:flutter/material.dart';

Widget containerComponent(BuildContext context, Widget childWidget,
    {double? height,
      double? width,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin,
      Color? color,
      Color? borderColor,
      double? borderWidth,
      double? borderRadius}) {
  return Container(
    height: height,
    width: width,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor!, width: borderWidth!),
        borderRadius: BorderRadius.circular(borderRadius!)),
    child: childWidget,
  );
}