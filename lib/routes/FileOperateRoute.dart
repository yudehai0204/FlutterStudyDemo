



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterdemo/common/DioManager.dart';
import 'package:path_provider/path_provider.dart';

class FileOperateRoute extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    return _FileOperateState();
  }

}


class _FileOperateState extends State<FileOperateRoute>{

  int _clickCount = 0;
  String result  = "";
  @override
  void initState() {
    super.initState();
    _readCount().then((value)  {
        setState(() {
          _clickCount = value;
        });
    });

    DioManager().get<String>("").then((value){
      print("result = $value");
      setState(() {
        result = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("点击次数：$_clickCount"),
            ElevatedButton(onPressed: (){
              setState(() {
                ++_clickCount;
              });
              _writeCount();

            }, child: Text("加一")),
            Text("读取结果：$result")
          ],
        ),),
    );
  }


  void _writeCount() async{
    try{
          File file =  File("${(await getApplicationCacheDirectory()).path}/count.txt");
          file.writeAsString("$_clickCount");
          print("write success");
        }catch( e){
          print("write error $e");
        }
  }

  Future<int> _readCount() async{
    try{
      File file =  File("${(await getApplicationCacheDirectory()).path}/count.txt");
      return int.parse(await file.readAsString());
      
    }catch( e){
      print("error $e");
      return 0;
    }
  }
}