
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starthirtyeight/components/parts/modal.dart';
import 'package:flutter/services.dart';

import 'package:starthirtyeight/components/parts/phonepad.dart';
import 'package:starthirtyeight/components/parts/totalnum.dart'; 

import 'package:starthirtyeight/HTTP/requests.dart' as Requests;
import 'package:starthirtyeight/static_state/static_state.dart' as StaticState;
import 'package:starthirtyeight/services/readwritephonenumber.dart' as Phone;
import 'dart:convert';

var step2View = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    if(widget.model.selectedListID==null||widget.model.userMongoose==null){
      return new Container(
        padding: EdgeInsets.all(20.0),
        child: Card(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child:Text(
              "Please complete Step 1. before moving on to Step 2.",
              style: TextStyle(
                fontSize: 40.0
              ),
              textAlign: TextAlign.center,
            ),
          )
        )
      );
    }else{
      return new Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
        child: Column(
          children: <Widget>[
            step2ViewUserData(widget),
            step2ViewAddButtons(widget),
            step2ViewPhonePad(widget), 
            step2ViewNumbersList(widget),
          ],
        )
      );
    }
  }
);

class DeleteCheck extends StatefulWidget{
  
  final offsetBool;

  DeleteCheck({
    Key key, 
    this.offsetBool
  }): super(key: key);

  @override 
  State<StatefulWidget> createState() {
    return new _MyDeleteCheck();
  }
}

class _MyDeleteCheck extends State<DeleteCheck> with TickerProviderStateMixin {
  AnimationController _controllerFloat;
  Animation<double> _offsetFloat; 

  @override
  void initState() {
    super.initState();

    _controllerFloat = new AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _offsetFloat = new Tween(
        begin: 10.0,
        end: 0.0,
      ).animate(_controllerFloat);

    _offsetFloat.addListener((){
      setState((){});
    });

    print('value of widget.offsetBool');
    print(widget.offsetBool);

    if(widget.offsetBool == "true"){
      _controllerFloat.forward();
    }else if(widget.offsetBool== "false"){
      _controllerFloat.reverse();
    }
  }
  
  @override
  Widget build(BuildContext context) {

    return new Container(
      alignment: FractionalOffset(_offsetFloat.value, 0.0),
      decoration: BoxDecoration(color: Colors.cyan),
      child: Text("hello there sailor")
      // child: Row(
      //   children: <Widget>[
      //     Expanded(
      //       child: RaisedButton(
      //         onPressed: (){

      //         },
      //         child: Text("ok")
      //       )
      //     )
      //   ],
      // ),
    );
  }
}

var step2ViewNumbersList = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;

    List<Widget> listColViewFunc(){
      List<Widget> list = new List<Widget>();
      try{
        for(var i = 0; i<widget.model.userMongoose.data['schema']['targetPhoneNumbers'].length; i++){
          print('inside for statement and value of i; ');
          print(i.toString());
          if(widget.model.selectedListID==widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['_id']){
            for(var x = 0; x<widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listNumbers'].length; x++){
              list.add(
                Container(
                  decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
                  width: width100,
                  height: 0.15*height100,
                  child: Card(
                    color: Color.fromRGBO(250, 250, 250, 0.8),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(2.0)),
                        Expanded(
                          child: Text(
                            widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listNumbers'][x].toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          )
                        ),
                        Padding(padding: EdgeInsets.all(20.0)),
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(30.0),
                                decoration: BoxDecoration(color: Colors.red),
                                height: 0.15*height100,
                                child: GestureDetector(
                                  onTap: (){
                                    print('gesture Tapped');
                                    widget.model.setDeleteNotify('true');
                                  },
                                  child:  Text(
                                    "Delete",
                                    style: TextStyle(
                                      fontSize: 20.0
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                )
                              ), 
                              widget.model.deleteNotify!=""?DeleteCheck(offsetBool: widget.model.deleteNotify):Container()
                            ],
                          )
                        )
                      ],
                    )
                  )
                )
              );              
            }
          }
        }
        
      }
      catch(e){
        print('there was some error');
      }
      return list;
    }
    if(widget.model.step2ChooseType=='view#'){
      return new Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8)),
        height: 0.6*height100,
        child: ListView(
          children: listColViewFunc()
        ),
      );
    }else{
      return new Container();
    }
  }
);

var step2ViewPhonePad = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    if(widget.model.step2ChooseType=='add#'){
      return new Column(
        children: <Widget>[
          new MyTotalnum(model: widget.model),
          new MyPhonePad(model: widget.model),
          Container(
            width: width100,
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(30.0)),
                Expanded(
                  child: RaisedButton(
                    onPressed: (){
                      var phone = new Phone.LocalPhoneStorage();
                      var requests = new Requests.POSTRequests();
                      waitForUserNumber() async{
                        var userNumber = await phone.readUserPhoneNumber();
                        var response = await requests.addUserTargetNumber(userNumber, widget.model.selectedListID, widget.model.callNumber);
                        var message = response.data['message'];
                        print('value of message');
                        print(message);
                        if(message=='successfully added target number'){
                          print('inside if callback in add number');
                          widget.model.setUserMongoose(response);
                        }
                      }
                      waitForUserNumber();
                    },
                    color: Colors.red,
                    child: Text(
                      "Add Number!",
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(30.0))
              ],
            ),
          )
        ],
      );
    }else{
      return new Container();
    }
  }
);


var step2ViewAddButtons = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new Row(
      children: <Widget>[
        Container(
          width: 0.48*width100,
          height: 0.08*height100,
          padding: EdgeInsets.fromLTRB(0.01*width100, 0.0, 0.01*width100, 0.0),
          child: new GestureDetector(
            onTap:(){
              widget.model.changeStep2ChooseType('add#');
            },
            child: Card(
              color: widget.model.step2ChooseType=='add#'?Colors.black:Colors.white,
              child: new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.02*height100, 0.0, 0.02*height100),
                child:Text("Add # to List",
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 15.0,
                    color: widget.model.step2ChooseType=='add#'?Colors.white:Colors.black,
                  )
                )
              )
            )
          )
        ), 
        Container(
          width: 0.48*width100,
          height: 0.08*height100,
          padding: EdgeInsets.fromLTRB(0.01*width100, 0.0, 0.01*width100, 0.0),
          child: new GestureDetector(
            onTap:(){
              widget.model.changeStep2ChooseType('view#');
            },
            child: Card(
              color: widget.model.step2ChooseType=='view#'?Colors.black:Colors.white,
              child: new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.02*height100, 0.0, 0.02*height100),
                child:Text("View #s in List",
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 15.0,
                    color: widget.model.step2ChooseType=='view#'?Colors.white:Colors.black,
                  )
                )
              )
            )
          )
        )
      ],
    );
  }
);


var step2ViewUserData = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){

    for(var i = 0; i<widget.model.userMongoose.data['schema']['targetPhoneNumbers'].length; i++){
      if(widget.model.selectedListID==widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['_id']){
        return new Container(
          decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
          child: new Card(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listName'].toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  )
                )
              ],
            ),
          ) 
        );
      }
      if(i==widget.model.userMongoose.data['schema']['targetPhoneNumbers'].length-1){
        return new Container(
          child: Text("no match found for userID in userDATA")
        );
      }
    } 
  }
);