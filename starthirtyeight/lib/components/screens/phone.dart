import 'package:flutter/material.dart';

import 'package:starthirtyeight/components/parts/number.dart';  
import 'package:starthirtyeight/scoped_state/scoped_state.dart';

class PhoneScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _PhoneScreenState();
  }
}

class _PhoneScreenState extends State<PhoneScreen> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text('About Us'),
      // ),
      body: new Center(
        // child: new Text('You are on the Phone Screen')
        child: Column(
          children: <Widget>[
            new Container(
              height: 200.0, 
              // decoration: BoxDecoration(color: Colors.blue[500])
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "1")
                ), 
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "2")
                ), 
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "3")
                )
              ]
            ),
            new Container(
              height: 5.0, 
              // decoration: BoxDecoration(color: Colors.blue[500])
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "4")
                ), 
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "5")
                ), 
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "6")
                )
              ]
            ),
            new Container(
              height: 5.0, 
              // decoration: BoxDecoration(color: Colors.blue[500])
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "7")
                ), 
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "8")
                ), 
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "9")
                )
              ]
            ),
            new Container(
              height: 5.0, 
              // decoration: BoxDecoration(color: Colors.blue[500])
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "*")
                ), 
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "0")
                ), 
                new Expanded(
                  child: new NumberBubble(model: PhoneModel(), numberDigit: "#")
                )
              ]
            ),
          ]
        )
      ),
    );
  }
}