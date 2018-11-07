import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';



class ModalPart extends StatelessWidget {

  String modalString;
  final MainModel model;

  ModalPart({
    Key key, 
    this.modalString,
    @required this.model, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ScopedModel<MainModel>(
      model: model,
      child: new MyModalPart(model: model, modalString: modalString)
    );
  }
}

class MyModalPart extends StatefulWidget {
  
  final MainModel model;
  String modalString;

  MyModalPart({
    Key key, 
    this.modalString,
    @required this.model, 
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _MyModalPart();
  }
}

class _MyModalPart extends State<MyModalPart> {
  @override
  Widget build(BuildContext context) {
    return widgetContainer(widget);
  }
}

var widgetContainer = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new Container(
      height: height100,
      width: width100,
      decoration: new BoxDecoration(color: new Color.fromRGBO(0, 0, 0, 0.5)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.3*height100),
          ),
          Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                ),
                Text(
                  "!ACHTUNG~!\n Phone Numbers are 10 digits long broheim", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                  )
                ), 
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                ),
                RaisedButton(
                  color: Colors.red,
                  child: Text("Got it!"),
                  onPressed: (){
                    widget.model.toggleErrorModal();
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                ),
              ]
            )
          )
        ],
      ),
    );
  }
);