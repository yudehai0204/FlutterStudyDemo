import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ListViewRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListTestState();
  }
}

class _ListTestState extends State<ListViewRoute> {
  final _lastTag = "#Loading#";
  var _words = <String>[];
  var _scrollController = ScrollController();

  @override
  void initState() {
    _words.add(_lastTag);
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      print("offset ${_scrollController.offset}");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("ListNotification Build");
    return NotificationListener(
      onNotification: (notification) {
        switch(notification.runtimeType) {
          case ScrollStartNotification : print("Start Scroll");
          case ScrollUpdateNotification : print(" Scrolling");
          case ScrollEndNotification : print("End Scroll");
          case OverscrollNotification : print("Scroll To Sliver");
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ListView"),
        ),
        body: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (_words[index] == _lastTag) {
                if (_words.length < 100) {
                  _loadData();
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 10,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: Text(
                      "没有更多了",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
              }
              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("点击了${_words[index]}"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(_words[index]),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
              );
            },
            itemCount: _words.length),
      ),
    );
  }

  void _loadData() {
    Future.delayed(Duration(seconds: 3)).then((e) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}
