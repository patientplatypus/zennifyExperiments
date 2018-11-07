import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart'; 


class MyNumberBubble extends StatefulWidget {

  final String numberDigit;
  final MainModel model;

  const MyNumberBubble({
    Key key, 
    this.numberDigit,
    @required this.model 
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

var buildFlatButton = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    return FlatButton(
      onPressed: (){
        print('inside onPressed of buildFlatButton in number.dart');
        model.appendNumber(widget.numberDigit);
      },
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
