import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LeftRightBox extends MultiChildRenderObjectWidget {
  LeftRightBox({Key? key, required List<Widget> children})
      : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderLeftRight();

  @override
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
    print("updateRenderObject");
  }
}

class _LeftRightParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderLeftRight extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _LeftRightParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _LeftRightParentData> {
  @override
  void setupParentData(covariant RenderObject child) {
    print("setupParentData");
    if (child.parentData is! _LeftRightParentData) {
      child.parentData = _LeftRightParentData();
    }
  }

  @override
  void performLayout() {
    print("performLayout");
    final BoxConstraints constraints = this.constraints;
    RenderBox leftChild = firstChild!;

    _LeftRightParentData childParentData =
        leftChild.parentData! as _LeftRightParentData;

    RenderBox rightChild = childParentData.nextSibling!;

    //我们限制右孩子宽度不超过总宽度一半
    rightChild.layout(
      constraints.copyWith(maxWidth: constraints.maxWidth / 2),
      parentUsesSize: true,
    );

    //调整右子节点的offset
    childParentData = rightChild.parentData! as _LeftRightParentData;
    childParentData.offset = Offset(
      constraints.maxWidth/2 - rightChild.size.width,
      0,
    );

    // layout left child
    // 左子节点的offset默认为（0，0），为了确保左子节点始终能显示，我们不修改它的offset
    leftChild.layout(
      //左侧剩余的最大宽度
      constraints.copyWith(
        maxWidth: constraints.maxWidth - rightChild.size.width,
      ),
      parentUsesSize: true,
    );

    //设置LeftRight自身的size
    size = Size(
      constraints.maxWidth,
      max(leftChild.size.height, rightChild.size.height),
    );
  }
  @override
   void paint(PaintingContext context, Offset offset) {
     defaultPaint(context, offset);
   }

   @override
   bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
     return defaultHitTestChildren(result, position: position);
   }
}
