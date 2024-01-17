

import 'package:flutter/material.dart';

class PageTestRoute extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    return _PageTestState();
  }
}


class _PageTestState extends State<PageTestRoute>{

  var _children = <Widget>[];

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < 5; i++){
      _children.add(Center(child: Text("$i", textScaler: TextScaler.linear(5),),));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("PageTest"),),
      body: Column(
        children: [
          Expanded(child: PageView(scrollDirection: Axis.vertical,children: _children,))
        ],
      ),
    );
  }
}