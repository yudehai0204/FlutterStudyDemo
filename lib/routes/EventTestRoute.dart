import 'package:flutter/material.dart';
import 'package:flutterdemo/common/LogUtil.dart';

const _tag ="EventTestRoute";
class EventTestRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _EventTestRouteState();
  }
}

class _EventTestRouteState extends State<EventTestRoute> {
  PointerEvent? _event;

  double _left = 0;
  double _top = 0;
  @override
  void initState() {
    super.initState();
  }

  void updatePointerEvent(PointerEvent event) {
    setState(() {
      _event = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          logI(_tag, "title builder");
          return Text("EventTest");
        }),
      ),
      body: Listener(
        onPointerDown: updatePointerEvent,
        onPointerMove: updatePointerEvent,
        onPointerUp: updatePointerEvent,
        child: Stack(
          children: [
            Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(builder: (ctx){
                            logI(_tag, "content builder");
                            return Text("${_event?.buttons} ; ${_event?.localPosition} ; ${_event
                                              ?.down}");
                          }),
                          Builder(builder: (ctx){
                            logI(_tag, "闲鱼 builder");
                            return ElevatedButton(onPressed: (){}, child: Text("闲鱼-躺平"));
                          })
                        ],
                      ),
                    ),
            Positioned(
                left: _left,
                top: _top,
                child: Builder(builder: (ctx){

                  return GestureDetector(
                    onPanDown: (e){print("Move Start");},
                    onPanUpdate: (e){
                      setState(() {
                        _left += e.delta.dx;
                        _top += e.delta.dy;
                      });
                    },
                    onPanEnd: (e){print("Move End");},
                    child:  CircleAvatar(child: Text("1"),),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
