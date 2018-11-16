
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
import 'dart:async';

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


class CancelDelete extends StatelessWidget{
  final MainModel model; 
  CancelDelete({
    Key key, 
    @required this.model,
  }): super(key: key);
  @override
  Widget build(BuildContext context){
    return ScopedModel<MainModel>(
      model: model,
      child: new MyCancelDelete(model: model)
    );
  }
}

class MyCancelDelete extends StatefulWidget {
  final Model model;

  MyCancelDelete({
    Key key, 
    @required this.model, 
  }): super(key: key);


  @override
  State<StatefulWidget> createState() {
    return new _MyCancelDelete();
  }
}

class _MyCancelDelete extends State<MyCancelDelete>{
  @override
    Widget build(BuildContext context) {
      return cancelDelete(widget);
    }
}

var cancelDelete = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          color: Colors.red,
          onPressed: (){
            // var listID = widget.model.
            var userNumber = widget.model.userMongoose.data['schema']['userPhoneNumber'];
            var listID = widget.model.selectedListID;
            var targetNumber = widget.model.deleteNumberString;

            waitForDeleteResponse() async{
              var requests = Requests.POSTRequests();
              var response = await requests.deleteUserTargetNumber(userNumber, listID, targetNumber);
              print('back from delete requests and value of requests: ');
              print(response);
              if(response.data['message']=='successfully deleted number'){
                print('message if successful!');
                widget.model.setUserMongoose(response);
              }
            }
            waitForDeleteResponse();
          },
          child: Text("Delete")
        ),
        RaisedButton(
          color: Colors.white,
          onPressed: (){
            widget.model.setDeleteNumberString("");
            widget.model.setDeleteNotify("");
          },
          child: Text("Cancel")
        )
      ]
    );
  }
);

class DeleteCheck extends StatefulWidget{
  
  final MainModel model;
  final offsetBool;
  final double widthSlide;
  bool showReturn = false;

  DeleteCheck({
    Key key, 
    this.offsetBool, 
    this.widthSlide, 
    this.showReturn,
    @required this.model,
  }): super(key: key);

  @override 
  State<StatefulWidget> createState() {
    return new _MyDeleteCheck();
  }
}

class _MyDeleteCheck extends State<DeleteCheck> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  Timer _timer; 
  
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetFloat = Tween<Offset>(begin: Offset(2.0, 0.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    
    _offsetFloat.addListener((){
      setState((){});
    });

    _controller.forward();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;

    return new SlideTransition(
      position: _offsetFloat,
      child: Container(
        padding: EdgeInsets.fromLTRB(0.05*width100, 0.0, 0.0, 0.0),
        height: 0.15*height100, 
        child: Container(
          color: Colors.cyan,
          width: 0.5*width100,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(5.0)),
              Text(
                'are you sure?', 
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              CancelDelete(model: widget.model)
            ],
          )
        )
      )
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(2.0)),
                        Container(
                          width: 0.40*width100,
                          child: Text(
                            widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listNumbers'][x].toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          )
                        ),
                        // Padding(padding: EdgeInsets.all(20.0)),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 0.55*width100,
                              padding: EdgeInsets.fromLTRB(0.05*width100, 0.0, 0.0, 0.0),//overflows on exact because of card margin
                              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
                              height: 0.15*height100,
                              child: GestureDetector(
                                onTap: (){
                                  print('gesture Tapped');
                                  widget.model.setDeleteNotify('true');
                                  widget.model.setDeleteNumberString(widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listNumbers'][x].toString());
                                },
                                child: Container(
                                  width: 0.50*width100,
                                  height: 0.15*height100,
                                  decoration: BoxDecoration(color: Colors.red),
                                  padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      fontSize: 20.0
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                )
                              )
                            ), 
                            widget.model.deleteNotify!=""&&    widget.model.deleteNumberString==widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listNumbers'][x].toString()?
                            DeleteCheck(model: model, offsetBool: widget.model.deleteNotify, widthSlide: 0.50*width100):
                            Container(width: 0.55*width100, height: 0.15*height100,padding: EdgeInsets.fromLTRB(0.05*width100, 0.0, 0.0, 0.0))
                            // Container(
                            //   padding: EdgeInsets.fromLTRB(0.05*width100+0.5, 0.0, 0.0, 0.0),
                            //   child: widget.model.deleteNotify!=""&&    widget.model.deleteNumberString==widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listNumbers'][x].toString()?
                            //     DeleteCheck(offsetBool: widget.model.deleteNotify, widthSlide: 0.5*width100):
                            //     Container(width: 0.50*width100, height: 0.15*height100,)
                            // ),
                          ],
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
                        print('value of reqs sent to addUserTargetNumber');
                        print('listID');
                        print(widget.model.selectedListID);
                        print('userNumber');
                        print(userNumber);
                        print('callNumber');
                        print(widget.model.callNumber);
                        var response = await requests.addUserTargetNumber(userNumber, widget.model.selectedListID, widget.model.callNumber);
                        var message = response.data['message'];
                        print('value of message');
                        print(message);
                        if(message=='successfully added target number'){
                          print('inside if callback in add number');
                          widget.model.setUserMongoose(response);
                          widget.model.setAnimPhoneAdded(true);
                        }
                      }
                      waitForUserNumber();
                      // widget.model.removeCallNumber();
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

class PhoneAddedAnim extends StatefulWidget{
  
  final MainModel model;
  // final offsetBool;
  // final double widthSlide;
  // bool showReturn = false;

  PhoneAddedAnim({
    Key key, 
    // this.offsetBool, 
    // this.widthSlide, 
    // this.showReturn,
    @required this.model,
  }): super(key: key);

  @override 
  State<StatefulWidget> createState() {
    return new _MyPhoneAddedAnim();
  }
}

class _MyPhoneAddedAnim extends State<PhoneAddedAnim> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  AnimationController _controller1;
  AnimationController _controller2;                                    
  Animation<Color> animation1;
  Animation<Color> animation2;   

  Timer _timer; 
  
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller1 = new AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller2 = new AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetFloat = Tween<Offset>(
      begin: Offset(0.0, 0.0), 
      end: Offset(0.0, -2.0)
    ).animate(_controller)
    ..addListener((){
      setState((){});
    });

    animation1 = new ColorTween(
      begin: const Color.fromRGBO(0, 100, 250, 1.0),
      end: const Color.fromRGBO(250, 100, 0, 0.0),
    ).animate(_controller1)
    ..addListener(() {
      setState((){});
    });


    animation2 = new ColorTween(
      begin: const Color.fromRGBO(250, 100, 0, 1.0),
      end: const Color.fromRGBO(0, 100, 250, 0.0),
    ).animate(_controller2)
    ..addListener(() {
      setState((){});
    });

    _controller.forward();
    _controller1.forward();
    _controller2.forward();
    


    _timer = new Timer(const Duration(seconds: 1), () {
      widget.model.setAnimPhoneAdded(false);
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.forward();
    _controller2.forward();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new SlideTransition(
      position: _offsetFloat,
      child: new Container(
        width: 0.48*width100,
        height: 0.20*height100,
        // decoration: BoxDecoration(color: animation1.value),
        // padding: EdgeInsets.fromLTRB(0.01*width100, 0.02*height100, 0.01*width100, 0.02*height100),
        // color: animation1.value,
        decoration: BoxDecoration(color: animation1.value),
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        
        // EdgeInsets.all(6.0),
        // padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "phone number added!",
              // decoration: new InputDecoration(contentPadding: const EdgeInsets.all(20.0),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: animation2.value,
              )
            ),
            // Padding(padding: EdgeInsets.all(2.0))
          ]
        )
        
        
        
       
        
      

        // child: Card(
        //   color: animation1.value,
        //   child: Container(
        //     padding: EdgeInsets.fromLTRB(0.01*width100, 0.02*height100, 0.01*width100, 0.02*height100),
        //     decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
        //     child: Text(
        //       "phone number added!",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 15.0,
        //         color: animation2.value,
        //       )
        //     )
        //   )
        // ) 
        // child: Card(
        //   child: Container(
        //     color: animation1.value,
        //     padding: EdgeInsets.fromLTRB(0.0, 0.02*height100, 0.0, 0.02*height100),
        //     child: Text(
        //       "phone number added!",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 15.0,
        //         color: animation2.value
        //       )
        //     )
        //   )
        // )
      )
    );
  }
}


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
                  style: TextStyle(
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
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 0.48*width100,
                      height: 0.08*height100,
                      child: Text("View #s",
                        textAlign: TextAlign.center,
                        style:TextStyle(
                          fontSize: 15.0,
                          color: widget.model.step2ChooseType=='view#'?Colors.white:Colors.black,
                        )
                      ),
                    ),
                    widget.model.animPhoneAdded==true?PhoneAddedAnim(model: model):Container()
                  ],
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