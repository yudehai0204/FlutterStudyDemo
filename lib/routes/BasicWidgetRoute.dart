import 'package:flutter/material.dart';
import 'package:flutterdemo/widgets/CustomLeftRightBox.dart';

class BasicWidgetRoute extends StatelessWidget {
  const BasicWidgetRoute({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Sample"),
      ),
      body: Column(
        children: [
          LeftRightBox(children: [
            Text("Left"),
            Text("Right")
          ]),
          Text(
            "Hello world",
            textAlign: TextAlign.center,
          ),
          Text(
            "Hello world " * 2,
            textAlign: TextAlign.center,
          ),
          Text(
            "CustomStyle  ",
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              height: 3,
            ),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(text: "Home: "),
            TextSpan(
                text: "https://blog.csdn.net/a940659387?type=blog",
                style: TextStyle(
                  color: Colors.blue,
                ))
          ])),
          TextField(
            autofocus: true,
            cursorColor: Colors.red,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.cyan,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              backgroundColor: Colors.cyan,
              valueColor: AlwaysStoppedAnimation(Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
