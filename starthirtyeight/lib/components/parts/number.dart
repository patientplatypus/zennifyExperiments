import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart'; 

class NumberBubble extends StatelessWidget{
  final PhoneModel model;
  final String numberDigit;

  const NumberBubble({
    Key key, 
    @required this.model, 
    this.numberDigit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PhoneModel>(
      model: model,
      child: new MyNumberBubble(numberDigit: numberDigit)
    );
  }
}

class MyNumberBubble extends StatefulWidget {

  final String numberDigit;

  const MyNumberBubble({
    Key key, 
    this.numberDigit
  }) : super(key: key);

  @override
  _MyNumberBubble createState() => _MyNumberBubble();
}

class _MyNumberBubble extends State<MyNumberBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3.0, right: 3.0),
      decoration: BoxDecoration(color: Colors.black87),
      child: buildFlatButton(widget)
    );
  }
}

var buildFlatButton = (widget) => ScopedModelDescendant<PhoneModel>(
  builder: (context, child, model){
    return FlatButton(
      onPressed: model.appendNumber(widget.numberDigit),
      child: Text(
        widget.numberDigit,
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.w900,
          color: Colors.cyan,
        ),
      ),
    );
  },
);
