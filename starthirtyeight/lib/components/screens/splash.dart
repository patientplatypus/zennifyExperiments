
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';


import 'package:starthirtyeight/components/parts/phonepad.dart';
import 'package:starthirtyeight/static_state/static_state.dart' as staticState;
import 'package:starthirtyeight/components/parts/totalnum.dart'; 

import 'package:starthirtyeight/components/parts/modal.dart';


class SplashScreen extends StatelessWidget{
  final MainModel model;
  const SplashScreen({
    Key key, 
    @required this.model, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ScopedModel<MainModel>(
      model: model,
      child: new MySplashScreen(model: model)
    );
  }
}

class MySplashScreen extends StatefulWidget {
  final MainModel model;
  const MySplashScreen({
    Key key, 
    @required this.model, 
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _MySplashScreen();
  }
}

class _MySplashScreen extends State<MySplashScreen> {

  var localPhoneNumber = '';
  var loadPhoneSwitch = false;
  var enterNumberButton = false;

  @override
  void initState() {
    super.initState();
    print('inside initstate in splash');
    widget.model.readFunc();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/space2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: phoneContainer(widget)
      )
    );
  }
}

var phoneContainer = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    if(widget.model.errorNumberModal == true){
      return new Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                width: width100,
                height: 0.30*height100, 
                child: new Image(
                  image: new AssetImage('assets/images/sixtyeightlogo.png')
                )
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Reach Out and Touch Someone.",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.cyan,
                    fontFamily: 'Pattaya'
                  )
                )
              ),
              phoneNumberSwitch(widget), 
            ],
          ), 
          new ModalPart(modalString: '!ACHTUNG~! \n Phone numbers need to be 10 digits long broheim', model: widget.model, modalType: 'error')
        ]
      );
    }else{
      return new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            width: width100,
            height: 0.30*height100, 
            child: new Image(
              image: new AssetImage('assets/images/sixtyeightlogo.png')
            )
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Reach Out and Touch Someone.",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.cyan,
                fontFamily: 'Pattaya'
              )
            )
          ),
          phoneNumberSwitch(widget), 
        ],
      );
    }
  }
);

var phoneNumberSwitch = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    if(widget.model.phoneNumber=='not initialized'){
      return new Container();
    }else if(widget.model.phoneNumber=='not found'||widget.model.phoneNumber==''){
      if(widget.model.enterNumberButton==false){
        return new Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                color: Colors.black87,
                child: Text("Enter Phone Number to Initiate *sixtyEight",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.cyan,
                    fontFamily: 'Pattaya',
                  ),
                ),
                onPressed: (){
                  widget.model.toggleEnterNumberButton();
                },
              )
            ],
          ) 
        );
      }else{
        return new Container(
          child: Column(
            children: <Widget>[
              MyTotalnum(model: widget.model),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              ),
              MyPhonePad(model: widget.model), 
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    color: Colors.red,
                    child: Text('Cancel', 
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.cyan
                      )
                    ),
                    onPressed: (){
                      widget.model.toggleEnterNumberButton();
                    },
                  ), 
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  ),
                  new RaisedButton(
                    color: Colors.black87,
                    child: Text('Set Number', 
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.cyan
                      )
                    ),
                    onPressed: (){
                      print('inside onPressed of Set Number');
                      if(widget.model.callNumber.length<10){
                        widget.model.toggleErrorModal();
                      }else{
                        widget.model.writeFunc(widget.model.callNumber);
                      }
                    },
                  )
                ],
              )
            ],
          ) 
        );
      }
    }else{
      return new Container(
        child: new Column(
          children: <Widget>[
            new Text('Your Number: ${widget.model.phoneNumber}', 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Colors.cyan
              )
            ),
            new RaisedButton(
              color: Colors.black87,
              child: Text('Clear Number', 
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.cyan
                )
              ),
              onPressed: (){
                print('inside clear number');
                widget.model.writeFunc('');
                widget.model.toggleEnterNumberButton();
              },
            )
          ],
        )
      );
    }
  }
);

