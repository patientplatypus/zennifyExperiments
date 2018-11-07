import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart'; 
import 'package:starthirtyeight/components/parts/number.dart'; 

class MyPhonePad extends StatefulWidget {

  final MainModel model;

  const MyPhonePad({
    Key key,
    @required this.model 
  }) : super(key: key);
  
  @override
  _MyPhonePad createState() => _MyPhonePad();
}

class _MyPhonePad extends State<MyPhonePad> {

  @override
  void initState() {
    super.initState();
    print('inside initstate in phonepad');
    print(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(color: new Color.fromRGBO(0, 0, 0, 0.0)),
        child: Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "1")
                ), 
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "2")
                ), 
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "3")
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
                  child: new MyNumberBubble(model: widget.model, numberDigit: "4")
                ), 
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "5")
                ), 
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "6")
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
                  child: new MyNumberBubble(model: widget.model, numberDigit: "7")
                ), 
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "8")
                ), 
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "9")
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
                  child: new MyNumberBubble(model: widget.model, numberDigit: "*")
                ), 
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "0")
                ), 
                new Expanded(
                  child: new MyNumberBubble(model: widget.model, numberDigit: "#")
                )
              ]
            )
          ]
        )
    );
  }
}