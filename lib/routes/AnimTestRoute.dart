import 'package:flutter/material.dart';

class AnimTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimTestState();
  }
}

class _AnimTestState extends State<AnimTestRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _animIsForward = true;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation = Tween(begin: 0.0, end: 300.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
    _animation.addStatusListener((status) {
      print("$status  ; $_animIsForward");
      switch (status) {
        case AnimationStatus.completed:
          _animIsForward = !_animIsForward;
          break;
        case AnimationStatus.dismissed:
          _animIsForward = !_animIsForward;
          break;
        default:
          break;
      }
    });
    _animation.addListener(() {
      setState(() => {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ElevatedButton(
          onPressed: () {},
          child: Text("AnimTest"),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UnconstrainedBox(
              child: Hero(
                tag: "anim",
                child: Image.asset(
                  'assets/images/1122.jpg',
                  width: 200,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  print(" play anim $_animIsForward");
                  if (_animIsForward) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                child: Text("播放动画"),
              ),
            ),
            UnconstrainedBox(
              child: Image.asset(
                'assets/images/1122.jpg',
                width: _animation.value,
                height: _animation.value,
              ),
            )
          ],
        ),
      ),
    );
  }
}
