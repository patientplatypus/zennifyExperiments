
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starthirtyeight/components/parts/modal.dart';
import 'package:flutter/services.dart';

import 'package:starthirtyeight/HTTP/requests.dart' as Requests;
import 'package:starthirtyeight/static_state/static_state.dart' as StaticState;
import 'package:starthirtyeight/services/readwritephonenumber.dart' as Phone;
import 'dart:convert';



class SettingsScreen extends StatelessWidget{
  final MainModel model;

  SettingsScreen({
    Key key, 
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ScopedModel<MainModel>(
      model: model,
      child: new MySettingsScreen(model: model)
    );
  }
}

class MySettingsScreen extends StatefulWidget {
  final Model model;
  // TextEditingController listNameController = TextEditingController();

  MySettingsScreen({
    Key key, 
    // this.listNameController,
    @required this.model, 
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return new _MySettingsScreen();
  }
}

class _MySettingsScreen extends State<MySettingsScreen> with TickerProviderStateMixin {
                 

  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new Material( 
      child: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/space2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            width: width100,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                ),
                cardButton(widget, "Step 1.", "Create or Select Phone List", "step1"),
                cardButton(widget, "Step 2.", "Add Numbers to List", "step2"),
                cardButton(widget, "Step 3.", "Choose Message and Times", "step3"),
                cardButton(widget, "Step 4.", "Fire the Lazerbeam", "Step 4."),
                routerView(widget)
              ],
            ),
          ),
          modalView(widget)
        ],
      )
    );
  }
}

var modalView = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    print('inside modalView');
    if (widget.model.showInfoModel==true){
      print('inside showInfoModel is true in modalView');
      print('value of widget.model.infoName:');
      print(widget.model.infoName);
      if(widget.model.infoName=="cat"){
        print('found value of cat in modalView');
        return ModalPart(modalString: 'Talk about cat option here', model: widget.model, modalType: "info");
      }else if(widget.model.infoName=='gov'){
        print('found value of gov in modalView');
        return ModalPart(modalString: 'Talk about gov option here', model: widget.model, modalType: "info");
      }else{
        return new Container();
      }
    }else{
      return new Container();
    }
  }
);


var step1ViewPrevLists = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    // for(var i = 0; i < strings.length; i++){
    //     list.add(new Text(strings[i]));
    // }
    // return new Row(children: list);
    List<Widget> listColViewFunc(){
      List<Widget> list = new List<Widget>();
      try{
        for(var i = 0; i<widget.model.userMongoose.data['schema']['targetPhoneNumbers'].length; i++){
          list.add(
            new Container(
              width: width100, 
              height: 0.2*height100,
              padding: EdgeInsets.all(5.0),
              child: Card(
                color: Color.fromRGBO(250, 250, 250, 0.5),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(2.0)),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: (){
                              //implement modal popup here with data
                            },
                            color: Colors.red,
                            child: Text(
                              'More Info',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            )
                          ),
                          Padding(padding: EdgeInsets.all(1.0)),
                          RaisedButton(
                            onPressed: (){
                              widget.model.recordSettingsRoute('step2');
                              widget.model.changeStep1ChooseType("new_list");
                              widget.model.setShowProductBanners(true);
                              widget.model.setShowNameList(false);
                              widget.model.setRecordingOption('none');
                              widget.model.setNewListName("");
                              widget.model.setNextStep("");
                              widget.model.setShowPrevLists(false);
                            },
                            color: Colors.cyan,
                            child: Text(
                              'Select List',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            )
                          ),
                          Padding(padding: EdgeInsets.all(5.0))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(2.0)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("List Name: " + widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listName'].toString(), 
                            style: TextStyle(
                              fontSize: 20.0
                            )
                          ),
                          Text("Recording Type: " + widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['recordingType'].toString(), 
                            style: TextStyle(
                              fontSize: 20.0
                            )
                          ),
                          Text("Number of #s: " + widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['listNumbers'].length.toString(), 
                            style: TextStyle(
                              fontSize: 20.0
                            )
                          ),
                        ],
                      )
                    )
                  ]
                )
              )
            )
          );
        }
      }
      catch(e){
        print('there was an error');
        print(e);
      }
      return list;
    }



    if (widget.model.showPrevLists==true){
      try{//try class for when widget.model.userMongoose is still waiting to populate from 'View Previous Lists' onPressed
        print('value of widget.model.userMongoose');
        print(widget.model.userMongoose);
        return new Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8)),
          height: 0.6*height100,
          child: ListView(
            children: listColViewFunc()
          )
        );
      }
      catch(e){
        return new Container();
      }
    }else{
      return new Container();
    }
  }
);

class ButtonFade extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ButtonFade();
  }
}

class _ButtonFade extends State<ButtonFade> with TickerProviderStateMixin {
  AnimationController _controller1;
  AnimationController _controller2;                                    
  Animation<Color> animation1;
  Animation<Color> animation2;   

  @override
  initState() {
    super.initState();
    // Because this class has now mixed in a TickerProvider
    // It can be its own vsync. This is what you need almost always
    _controller1 = new AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller2 = new AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    // A tween that begins at grey and ends at a green
    // The chained 'animate' function is required
    animation1 = new ColorTween(
      begin: const Color.fromRGBO(0, 100, 250, 1.0),
      end: const Color.fromRGBO(250, 100, 0, 1.0),
    ).animate(_controller1)
    ..addListener(() {
      setState((){});
    });
    animation1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller1.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller1.forward();
      }
    });
    // Tell the animation to start
    _controller1.forward();

    animation2 = new ColorTween(
      begin: const Color.fromRGBO(250, 100, 0, 1.0),
      end: const Color.fromRGBO(0, 100, 250, 1.0),
    ).animate(_controller2)
    // This is a another chained method for Animations.
    // It will call the callback passed to it everytime the
    // value of the tween changes. Call setState within it
    // to repaint the widget with the new value
    ..addListener(() {
      setState((){});
    });
    animation2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller2.forward();
      }
    });
    // Tell the animation to start
    _controller2.forward();
  }             

  @override
  dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }     

  @override
  Widget build(BuildContext context){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
          colors: [animation1.value, animation2.value], // whitish to gray
          tileMode: TileMode.repeated, 
        )
      ),
      padding: EdgeInsets.all(20.0),
      height: 0.15*height100, 
      width: width100,
      child: Text(
        "Tap to Go to Step 2", 
        style: TextStyle(fontSize: 30.0),
        textAlign: TextAlign.center,
      )
    );
  }
}

var nextStepButton = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    if (widget.model.nextStep == 'step2'){
      return new Container(
        width: width100,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ButtonFade(),
                GestureDetector(
                  onTap: (){
                    print('tapped in stacked context');
                    widget.model.recordSettingsRoute('step2');
                    widget.model.changeStep1ChooseType("new_list");
                    widget.model.setShowProductBanners(true);
                    widget.model.setShowNameList(false);
                    widget.model.setRecordingOption('none');
                    widget.model.setNewListName("");
                    widget.model.setNextStep("");
                  },
                  child: new Container(
                    padding: EdgeInsets.all(20.0),
                    height: 0.15*height100, 
                    width: width100,
                    decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.0)),
                    child: Container()
                  ) 
                ),
              ],
            ) 
            // Padding(padding: EdgeInsets.all(20.0))
          ],
        )
      );
    }else{
      return new Container();
    }
  }
);

var step1ViewListName = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    print('inside step1ViewListName');
    print('value of widget.model.showNameList');
    print(widget.model.showNameList);
    if(widget.model.showNameList==true){
      print('inside step1ViewListName if statement');
      return new Column(
        children: <Widget>[
          new Container(
            width: width100,
            decoration: BoxDecoration(color: Colors.white),
            child: TextField(
              onChanged: (e){
                print('inside onchanged in textfield');
                print('value of e');
                print(e);
                widget.model.setNewListName(e);
              },
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: 'Name your new list', 
                fillColor: Colors.white,
              ),
              textAlign: TextAlign.center,
              // controller: listNameController,
            )
          )
        ],
      );
    }else{
      return new Container();
    }
  }
);

var step1ViewListInstr = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    if(widget.model.recordingOption!='none'){
      if(widget.model.newListName==""){
        return new Column(
          children: <Widget>[
            Card(
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  "Add a name to the list of numbers you want to call with the ${widget.model.recordingOption} recording.",
                  style: TextStyle(fontSize: 25.0),
                )
              )
            ), 
          ],
        );
      }else{
        return new Column(
        children: <Widget>[
            Card(
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Text(
                      "You are about to make a new list called ${widget.model.newListName} using the ${widget.model.recordingOption} recording. Is this what you want?",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.red,
                          padding: EdgeInsets.all(2.0),
                          onPressed: (){
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            widget.model.changeStep1ChooseType("new_list");
                            widget.model.setShowProductBanners(true);
                            widget.model.setShowNameList(false);
                            widget.model.setRecordingOption('none');
                            widget.model.setNewListName("");
                          },
                          child: Text(
                            "Cancel"
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        RaisedButton(
                          color: Colors.cyan,
                          padding: EdgeInsets.all(2.0),
                          onPressed: (){
                            var requests = Requests.POSTRequests();
                            var phone = Phone.LocalPhoneStorage();
                            
                            print('inside onPressed OK and value of userNumber');

                            waitForUserNumber() async{
                              print('inside waitForUserNumber()');
                              var userNumber = await phone.readUserPhoneNumber();
                              print(userNumber);
                              print('value of newListName');
                              print(widget.model.newListName);
                              var requestReturn = await requests.addUserList(userNumber, widget.model.newListName, widget.model.recordingOption);
                              print('value of requestReturn');
                              print(requestReturn);
                              if(requestReturn['message']=='addUserList successful'){
                                print('value of targetPhoneNumbers');
                                print(requestReturn['schema']['targetPhoneNumbers']);
                                widget.model.setNextStep('step2');
                              }
                            }
                            waitForUserNumber();
                          },
                          child: Text(
                            "OK"
                          ),
                        )
                      ],
                    )
                  ],
                )
              )
            ), 
          ],
        );
      }
    }else{
      return new Container();
    }
  }
);

var step1ViewProductBanner = (widget, bannerName) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    if(widget.model.showProductBanners==true){
      if(bannerName=='cat'){
        return new Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              // width: width100,
              height: 0.25*height100, 
              child: new GestureDetector(
                onTap: (){
                  widget.model.setRecordingOption('cat');
                  widget.model.setShowNameList(true);
                  widget.model.setShowProductBanners(false);
                },
                child: new Image(
                  image: new AssetImage('assets/images/catOption.png')
                )
              ) 
            ),
            Container(
              padding: EdgeInsets.fromLTRB(2.0, 10.0, 0.0, 0.0),
              child: new GestureDetector(
                onTap: (){
                  print('cat info tapped');
                  widget.model.setInfoModel(true, 'cat');
                },
                child: Icon(
                  FontAwesomeIcons.solidQuestionCircle, 
                  color: Colors.cyan,
                  size: 50.0
                )
              )
            )
          ],
        ); 
      }else if(bannerName=='gov'){
         return new Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              // width: width100,
              height: 0.25*height100, 
              child: new GestureDetector(
                onTap: (){
                  widget.model.setRecordingOption('gov');
                  widget.model.setShowNameList(true);
                  widget.model.setShowProductBanners(false);
                },
                child: new Image(
                  image: new AssetImage('assets/images/govOption.png')
                )
              )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(2.0, 10.0, 0.0, 0.0),
              child: new GestureDetector(
                onTap: (){
                  print('gov info tapped');
                  widget.model.setInfoModel(true, 'gov');
                },
                child: Icon(
                  FontAwesomeIcons.solidQuestionCircle, 
                  color: Colors.cyan,
                  size: 50.0
                )
              )
            )
          ],
        );
      }
    }else{
      return new Container();
    }
  }
);

var step1View = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: 0.48*width100,
                height: 0.08*height100,
                padding: EdgeInsets.fromLTRB(0.01*width100, 0.0, 0.01*width100, 0.0),
                child: new GestureDetector(
                  onTap: (){
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    widget.model.setShowPrevLists(false);
                    widget.model.changeStep1ChooseType("new_list");
                    widget.model.setShowProductBanners(true);
                    widget.model.setShowNameList(false);
                    widget.model.setRecordingOption('none');
                    widget.model.setNewListName("");
                    widget.model.setNextStep("");
                    widget.model.setShowPrevLists(false);
                  },
                  child: Card(
                    color: widget.model.step1ChooseType=='new_list'?Colors.black:Colors.white,
                    child: new Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.02*height100, 0.0, 0.02*height100),
                      child:Text("Create New List",
                        textAlign: TextAlign.center,
                        style:TextStyle(
                          fontSize: 15.0,
                          color: widget.model.step1ChooseType=='new_list'?Colors.white:Colors.black,
                        )
                      )
                    )
                  )
                )
              ),
              new Container(
                width: 0.48*width100,
                height: 0.08*height100,
                padding: EdgeInsets.fromLTRB(0.01*width100, 0.0, 0.01*width100, 0.0),
                child: new GestureDetector(
                  onTap: (){
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    widget.model.changeStep1ChooseType("view_lists");
                    widget.model.setShowProductBanners(false);
                    widget.model.setShowNameList(false);
                    widget.model.setShowPrevLists(true);
                    widget.model.setRecordingOption('none');
                    widget.model.setNewListName("");
                    widget.model.setNextStep("");
                    var phone = new Phone.LocalPhoneStorage();
                    var requests = new Requests.POSTRequests();
                    waitForUserNumber() async{
                      var userNumber = await phone.readUserPhoneNumber();
                      print('value of userNumber after waiting, ');
                      print(userNumber);
                      var response = await requests.getUserData(userNumber);
                      widget.model.setUserMongoose(response);
                    }
                    waitForUserNumber();
                  },
                  child: Card(
                    color: widget.model.step1ChooseType=='view_lists'?Colors.black:Colors.white,
                    child: new Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.02*height100, 0.0, 0.02*height100),
                      child:  Text("View Previous Lists", 
                        textAlign: TextAlign.center,
                        style:TextStyle(
                          fontSize: 15.0,
                          color: widget.model.step1ChooseType=='view_lists'?Colors.white:Colors.black,
                        )
                      )
                    )
                  )
                )
              ), 
            ]
          ), 
          step1ViewProductBanner(widget, 'cat'),
          step1ViewProductBanner(widget, 'gov'),
          step1ViewListName(widget), 
          step1ViewListInstr(widget), 
          step1ViewPrevLists(widget),
          nextStepButton(widget)
        ]
    );
  }
);


var routerView = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    if(widget.model.settingsCurrentRoute=='step1'){
      return step1View(widget);
    }else if(widget.model.settingsCurrentRoute=='step2'){
      return new Container();
    }else if(widget.model.settingsCurrentRoute=='step3'){
      return new Container();
    }else if(widget.model.settingsCurrentRoute=='step4'){
      return new Container();
    }else{
      return new Container();
    }
  }
);

var cardButton = (widget, cardTitle, cardMessage, routerName) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;

    backButton(){
      if(widget.model.settingsCurrentRoute!='menu'){
        return new Container(
          child: RaisedButton(
            color: Colors.cyan,
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text(
              "Back to Menu",
              style: TextStyle(color: Colors.red),),
            onPressed: (){
              widget.model.recordSettingsRoute('menu');
            },
          )
        );
      }else{
        return new Container();
      }
    };

    if(widget.model.settingsCurrentRoute=='menu' || widget.model.settingsCurrentRoute==routerName){
      return new Stack(
        children: <Widget>[
          Container(
            width: 0.95*width100,
            padding: EdgeInsets.fromLTRB(0.03*width100, 0.0, 0.0, 20.0),
            child: new GestureDetector(
              onTap: (){
                print('card tapped');
                print(routerName);
                widget.model.recordSettingsRoute(routerName);
              },
              child: Card(
                color: widget.model.settingsCurrentRoute=='menu'?Colors.white:Colors.black,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(cardTitle, 
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.red,
                        )
                      )
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(cardMessage, 
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.cyan,
                        )
                      )
                    )
                  ],
                )
              )
            )
          ), 
          backButton()
        ],
      );
    }else{
      return new Container();
    }
  }
);
