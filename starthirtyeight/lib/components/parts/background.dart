import 'package:flutter/material.dart';

// About page...
class BackgroundImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BackgroundImage();
  }
}

class _BackgroundImage extends State<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new Container(
        height: height100,
        width: width100,
        child: new Image(
          image: new AssetImage('assets/images/space2.jpg'), 
        fit: BoxFit.fill)
    ); 
  }
}