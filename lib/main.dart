import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'animtest.dart';

import 'animatest2.dart' as test2;
import 'routemanager.dart';

import 'dart:async';
main(List<String> args) {
  
  runZoned((){

  });

  runApp(MaterialApp(
    title: "title",
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    routes: {
      "new_page": (context) => NewHome(),
    },
    home: OldHome(),
  ));
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var con1 = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "images/lake.jpg",
            fit: BoxFit.fitWidth,
          ),
          ListTile(
            title: Text(
              "Oeschinen Lake Campground",
              style: TextStyle(
                backgroundColor: Colors.blue,
              ),
            ),
            subtitle: Text("Kandersteg,Switzerland"),
            trailing: SizedBox(
              width: 100,
              height: 50,
              child: BtnWidget(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.call,
                  ),
                  Text("CALL"),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.navigation),
                  Text("ROUTE"),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.share),
                  Text("SHARE"),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
                "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run."),
          ),
        ],
      ),
    );

    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(data: MediaQueryData(), child: con1),
      ),
    );
  }
}

class _BtnState extends State<BtnWidget> {
  var _isFavorited = false;
  var _favoriteCount = 39;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: _changeState,
          icon: _isFavorited ? Icon(Icons.star) : Icon(Icons.star_border),
        ),
        Text("$_favoriteCount"),
      ],
    );
  }

  _changeState() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
      } else {
        _favoriteCount += 1;
      }
      _isFavorited = !_isFavorited;
    });
  }
}

class BtnWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BtnState();
  }
}

class _CallState extends State<CallWidget> {
  var _textState = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _textState = !_textState;
        });
      },
      child: Container(
        child: Text(
          "管理自身状态",
          style: TextStyle(
            color: _textState ? Colors.blue : Colors.red,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

class CallWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CallState();
  }
}

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentState();
  }
}

class _ParentState extends State<ParentWidget> {
  var _textState = false;

  void _handStateChanged() {
    setState(() {
      _textState = !_textState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChildWidget(
      handStateChanged: _handStateChanged,
      textState: _textState,
    );
  }
}

class ChildWidget extends StatelessWidget {
  var handStateChanged;

  var textState;

  ChildWidget(
      {Key key, @required this.handStateChanged, this.textState = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handStateChanged,
      child: Text(
        "父widget对状态进行管理",
        style: TextStyle(
          fontSize: 40,
          color: textState ? Colors.red : Colors.blue,
        ),
      ),
    );
  }
}
