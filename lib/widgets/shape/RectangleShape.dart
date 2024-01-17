


import 'package:flutter/material.dart';

dynamic createCornerRect(int radius,List<Color> colors,Widget child){

  return DecoratedBox(decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: colors,
    ),
    borderRadius: BorderRadius.circular(radius.toDouble()), // 设置圆角半径
  ),
  child: child,);
}