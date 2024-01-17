



import 'package:flutter/widgets.dart';

class CustomWidget extends LeafRenderObjectWidget{
  @override
  RenderObject createRenderObject(BuildContext context) {

    return _RenderCustomObject();
  }


  @override
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
  }



}


class _RenderCustomObject extends RenderBox{

  @override
  void performLayout() {
  }

  @override
  void paint(PaintingContext context, Offset offset) {
  }

}