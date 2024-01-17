import 'package:flutter/material.dart';
import 'package:flutterdemo/common/LogUtil.dart';

const _tag = "CounterRoute";

class CounterRoute extends StatefulWidget {
  const CounterRoute({Key? key});

  final initValue = 0;

  @override
  State<CounterRoute> createState() {
    return _CounterPage();
  }
}

class _CounterPage extends State<CounterRoute> {
  var _counter = 0;

  @override
  void initState() {
    super.initState();
    logI(_tag, "initState");
  }

  @override
  void didUpdateWidget(covariant CounterRoute oldWidget) {
    super.didUpdateWidget(oldWidget);
    logI(_tag, "didUpdateWidget");
  }

  @override
  void dispose() {
    logI(_tag, "dispose");
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    logI(_tag, "didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    logI(_tag, "deactivate");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    logI(_tag, "build");
    return Scaffold(
        appBar: AppBar(
          title: Text("Counter Route"),
        ),
        body: Center(
            child: Column(
          children: [
            Builder(builder: (context) {
              logI(_tag, "content build");
              return Text("$_counter");
            }),
            Builder(builder: (ctx) {
              logI(_tag, "button build");
              return TextButton(
                  onPressed: () => {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Only Test")))
                      },
                  child: Text("click me"));
            }),
          ],
        )),
        floatingActionButton: Builder(builder: (ctx){
          logI(_tag, "float build");
          return FloatingActionButton(
                    onPressed: () => {
                      setState(() {
                        ++_counter;
                      })
                    },
                    child: Text("+"));
        }),
        );
  }
}
