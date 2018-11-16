import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTotalnum extends StatefulWidget{
  final MainModel model;
  const MyTotalnum({
    Key key,
    @required this.model
  }) : super(key: key);
  @override
  _MyTotalnum createState() => _MyTotalnum();
}

class _MyTotalnum extends State<MyTotalnum>{
  @override
  void initState() {
      super.initState();
      print('inside initState for TotalNum of input phone number/pad');
      widget.model.removeCallNumber();
    }
  @override
  Widget build(BuildContext context){
    return new Material(
      child: Container(
        decoration: BoxDecoration(color: Colors.black87),
        child: Row(
          children: <Widget>[
            new Expanded(
              child: displayNumber(widget)
            ),
            backSpace(widget)
          ]
        )
      )
    );
  }
}

var backSpace = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    if (model.callNumber.length>0){
      return new Container(
        decoration: new BoxDecoration(color: new Color.fromRGBO(0, 0, 0, 0.0)),
        // decoration: BoxDecoration(color: Colors.black87),
        child: new IconButton(
          icon: new Icon(
            FontAwesomeIcons.backspace, 
            color: Colors.blue.shade400
          ), 
          onPressed: () { 
            print("Pressed");
            model.deleteNumber();
          }
        )
      );
    }else{
      return Container();
    }
  }
);

var displayNumber = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){//reset on each load of displayNumber
    return Container(
      decoration: new BoxDecoration(color: new Color.fromRGBO(0, 0, 0, 0.0)),
      // decoration: BoxDecoration(color: Colors.black87),
      child: Text(
         model.callNumber,
         textAlign: TextAlign.center,
         style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.w900,
          color: Colors.blue.shade400
        ))
    );
  }
);

