import 'package:flutter/widgets.dart';

class AnimTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimTestState();
  }
}

class AnimTestState extends State<AnimTestWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 300.0).animate(_controller)
      ..addListener(() {
        setState(() {
          print("change state");
        });
      });

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var view = Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Text(
          "点击测试",
          style: TextStyle(fontSize: _animation.value),
        ),
      ),
    );

    return view;
  }
}
