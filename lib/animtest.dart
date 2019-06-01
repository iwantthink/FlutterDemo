import 'package:flutter/widgets.dart';

class AnimTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimTestState2();
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
//          print("change state");
        });
      })
      ..addStatusListener((AnimationStatus status) {
        print("status changed , status = ${status}");

        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
//        else if (status == AnimationStatus.dismissed) {
//          _controller.forward();
//        }
      });
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
        child: GestureDetector(
          onDoubleTap: () {
            print("click me");
            _controller.forward(from: 0.0);
          },
          child: Text(
            "点击测试",
            style: TextStyle(
                fontSize: _animation.value == 0.0 ? 20 : _animation.value),
          ),
        ),
      ),
    );

    return view;
  }
}

class AnimTestState2 extends State<AnimTestWidget>
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

    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);



    _animation = Tween(begin: 0.0, end: 300.0).animate(curvedAnimation);

    _animation.addStatusListener((status) {
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var view = AnimatedBuilder(
      animation: _animation,
      builder: ((BuildContext context, Widget child) {
        return new Text(
          "点击我进行测试",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: _animation.value),
        );
      }),
    );

    return view;
  }
}

class TestAnimatedWidget extends AnimatedWidget {
  AnimationController controller;

  TestAnimatedWidget({Animation<double> animation, this.controller})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: GestureDetector(
          onDoubleTap: () {
            print("click me");
            controller.forward(from: 0.0);
          },
          child: Text(
            "点击测试",
            style: TextStyle(
                fontSize: animation.value == 0.0 ? 20 : animation.value),
          ),
        ),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  Widget child;

  Animation<double> animation;

  GrowTransition({this.child, this.animation});

  Tween _animationSize;
  Tween _animationOpacity;

  @override
  Widget build(BuildContext context) {
    _animationSize = Tween(begin: 0.0, end: 300.0);
    _animationOpacity = Tween(begin: 0.1, end: 1.0);

    return Center(
      child: AnimatedBuilder(
          child: child,
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: _animationOpacity.evaluate(animation),
              child: Container(
                height: _animationSize.evaluate(animation),
                width: _animationSize.evaluate(animation),
                child: child,
              ),
            );
          }),
    );
  }
}

class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        "点击测试",
      ),
    );
  }
}
