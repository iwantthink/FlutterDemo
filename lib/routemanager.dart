import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

class OldHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            Navigator.pushNamed(context, "new_page", arguments: "sjb");
          },
          child: Image.asset("images/lake.jpg"),

        ),
      ),
    );
  }
}

class NewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print("args = $args");


    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Text(
          "new text",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
