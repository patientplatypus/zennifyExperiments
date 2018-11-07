import 'package:flutter/material.dart';

// About page...
class AboutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(color: new Color.fromRGBO(0, 0, 0, 0.0)),
        child: new Text('You are in the about page!')
    );
  }
}