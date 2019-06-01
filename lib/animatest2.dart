import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';


class Test extends AnimatedWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}

class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestState();
  }
}

class _TestState extends State<TestWidget> with SingleTickerProviderStateMixin {
  Tween _tween;
  Tween _tweenColor;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _tween = new Tween(begin: 0.0, end: 1000.0);
    _tweenColor = ColorTween(
      begin: Color.fromARGB(255, 255, 255, 255),
      end: Color.fromARGB(0, 255, 255, 255),
    );
    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();

  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        "点击测试",
        style: TextStyle(
//          fontSize: _tween.evaluate(_controller),
          color: _tweenColor.evaluate(_controller),
          fontSize: _controller.value * 100,
        ),
      ),
    );
  }
}
