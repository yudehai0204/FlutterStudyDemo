

import 'package:flutter/material.dart';

class CustomAnimatedBox extends StatefulWidget{
  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration? reverseDuration;
  CustomAnimatedBox({Key? key, required this.decoration,required this.child,this.curve = Curves.linear, required this.duration,this.reverseDuration}):super(key:key);


  @override
  State<StatefulWidget> createState() {
    return _CustomAnimatedBoxState();
  }


}


class _CustomAnimatedBoxState extends State<CustomAnimatedBox>{

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

}