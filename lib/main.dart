import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdemo/common/LogUtil.dart';
import 'package:flutterdemo/routes/AnimTestRoute.dart';
import 'package:flutterdemo/routes/AsyncTestRoute.dart';
import 'package:flutterdemo/routes/BasicWidgetRoute.dart';
import 'package:flutterdemo/routes/CounterRoute.dart';
import 'package:flutterdemo/routes/CustomPaintRoute.dart';
import 'package:flutterdemo/routes/EventTestRoute.dart';
import 'package:flutterdemo/routes/FileOperateRoute.dart';
import 'package:flutterdemo/routes/ListViewRoute.dart';
import 'package:flutterdemo/routes/PageViewRoute.dart';
import 'package:flutterdemo/routes/ShareStateRoute.dart';
import 'package:flutterdemo/routes/WidgetGroupRoute.dart';
import 'package:flutterdemo/widgets/TapBox.dart';

var _tag = "SSS";

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    logE(_tag, "receive Error ${details.exception}");
  };
  runApp(Center(child: const MyApp()));
  logE(_tag, "1111");
  logD(_tag, "222");
}

Map<String, WidgetBuilder> routes = {
  "customRoute": (context) => CounterRoute(),
  "childControl": (context) => TapBoxA(),
  "parentControl": (context) => ParentWidget(),
  "BasicWidget": (context) => BasicWidgetRoute(),
  "WidgetGroup": (context) => WidgetGroupRoute(),
  "List": (context) => ListViewRoute(),
  "PageTest": (context) => PageTestRoute(),
  "EventTestRoute": (context) => EventTestRoute(),
  "CustomPaint": (context) => CustomPainterRoute(),
  "ShareRoute": (context) => ShareTestRoute(),
  "FileRoute": (context) => FileOperateRoute(),
  "AnimRoute": (context) => AnimTestRoute(),
  "AsyncTestRoute": (context) => AsyncTestRoute(),
  "/": (context) => MyHomePage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: routes,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (RouteSettings settings) {
        logE(_tag, "onGenerateRoute ${settings.name}");
        return MaterialPageRoute(builder: (context) {
          return TapBoxA();
        });
      },
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel("PlatformReceive");
  static const receiveChannel = MethodChannel("FlutterReceive");
  int _counter = 0;
  var current = WordPair.random();
  DateTime? _lastTime;

  void getNext() {
    current = WordPair.random();
  }

  @override
  void initState() {
    receiveChannel.setMethodCallHandler((call) async {
      logD(_tag, "ReceiveMethod ${call.method} ${call.arguments}");
      if (call.method == "changeCount") {
        setState(() {
          _counter = call.arguments;
        });
      }
    });
    super.initState();
  }

  dynamic _incrementCounter() {
    platform.invokeMethod("getContent").then((value){print("getcontent result = $value");});
    setState(() {
      _counter++;
      getNext();
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return PopScope(
        canPop: false,
        onPopInvoked: (did) {
          if (did) {
            return;
          }
          var canPop = (_lastTime != null &&
              (DateTime.now().difference(_lastTime!) < Duration(seconds: 1)));
          print("did $did   canPop $canPop");
          if (canPop) {
            exit(0);
            return;
          }
          _lastTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("再次点击退出"),
            duration: Duration(milliseconds: 500),
          ));
        },
        child: Scaffold(
          appBar: AppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
          ),
          body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: ListView(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: InkWell(
                    child: Card(
                        color: Colors.teal,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text("GoPlatformPage"),
                        )),
                    onTap: () {
                      platform.invokeMethod("goOther");
                    }),
              ),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("GoCounter"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "customRoute");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("WidgetControl"),
                      )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TapBoxA();
                    }));
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("CustomPaint"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "CustomPaint");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("ParentControl"),
                      )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ParentWidget();
                    }));
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("BasicWidget"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "BasicWidget");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              UnconstrainedBox(
                child: InkWell(
                    child: Hero(
                      tag: "anim",
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/1122.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "AnimRoute");
                    }),
              ),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("WidgetGroup"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "WidgetGroup");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("FileRoute"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "FileRoute");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("List"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "List");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("ShareState"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "ShareRoute");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("EventTestRoute"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "EventTestRoute");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("AsyncTest"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "AsyncTestRoute");
                  }),
              Padding(padding: EdgeInsets.all(10)),
              InkWell(
                  child: Card(
                      color: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("PageTest"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "PageTest");
                  }),
              InkWell(
                child: Image.asset(
                  'assets/images/1122.jpg',
                  width: 100,
                  height: 200,
                ),
                onTap: () => {debugDumpApp()},
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    "https://www.itying.com/images/flutter/1.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(30))
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
