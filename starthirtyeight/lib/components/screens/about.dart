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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('About Us'),
      ),
      body: new Center(
        child: new Text('You are in the about page!')
      ),
    );
  }
}