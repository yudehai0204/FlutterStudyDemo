

import 'package:flutter/material.dart';

class AsyncTestRoute extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return _AsyncTestState();
  }

}

class _AsyncTestState extends State<AsyncTestRoute>{


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("AsyncTest"),),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(future: Future<String>.delayed(Duration(seconds: 3),()=>"我是结果"), builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return Text("Error : ${snapshot.error}");
                }else{
                  return Text("Data : ${snapshot.data}");
                }
              }else{
                return CircularProgressIndicator();
              }
            })

          ],
        ),
      ),

    );
  }
}