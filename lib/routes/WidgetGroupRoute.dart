import 'package:flutter/material.dart';
import 'package:flutterdemo/common/LogUtil.dart';

import '../widgets/shape/RectangleShape.dart';

const _tag = "WidgetGroupRoute";

class WidgetGroupRoute extends StatefulWidget {
  const WidgetGroupRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WidgetGroupRouteState();
  }
}

class _WidgetGroupRouteState extends State<WidgetGroupRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "WidgetGroupRoute",
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                child: Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 100,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.red,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.yellow,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Wrap(
                spacing: 8,
                // 主轴(水平)方向间距
                runSpacing: 4,
                // 纵轴（垂直）方向间距
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Chip(label: Text('Hamilton')),
                  Text("TEXT"),
                  ElevatedButton(onPressed: () {}, child: Text("Button")),
                  ElevatedButton(onPressed: () {}, child: Text("Button")),
                  ElevatedButton(onPressed: () {}, child: Text("Button")),
                  ElevatedButton(onPressed: () {}, child: Text("Button")),
                  ElevatedButton(onPressed: () {}, child: Text("Button")),
                  _LayoutBuilderTest(),
                ],
              ),
              createCornerRect(10, [Colors.black, Colors.cyanAccent],
                  Padding(padding: EdgeInsets.all(30))),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.translate(
                    offset: Offset(-20, -20),
                    child: Padding(padding: EdgeInsets.all(20),child: Text("Test"),),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                constraints: BoxConstraints.tightFor(width: 100,height: 50),
                decoration: BoxDecoration(color: Colors.black),
                alignment: Alignment.center,
                child: Text("Test",style: TextStyle(color: Colors.blue),),
              ),
            ],
          ),

        ));
  }
}

class _LayoutBuilderTest extends StatelessWidget {
  _LayoutBuilderTest();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      logI(_tag, "_LayoutBuilderTest  constraints = $constraints");
      return Column(
        children: [ElevatedButton(onPressed: () {}, child: Text("Button"))],
      );
    });
  }
}

class _FlowTestDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  _FlowTestDelegate();

  @override
  void paintChildren(FlowPaintingContext context) {}

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    throw UnimplementedError();
  }
}
