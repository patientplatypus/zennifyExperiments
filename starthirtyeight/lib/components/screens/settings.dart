
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

import 'package:starthirtyeight/components/subscreens/settings/settingsView1.dart' as View1;
import 'package:starthirtyeight/components/subscreens/settings/settingsView2.dart' as View2;

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
  }): super(key: key);


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

var routerView = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    if(widget.model.settingsCurrentRoute=='step1'){
      return View1.step1View(widget);
    }else if(widget.model.settingsCurrentRoute=='step2'){
      return View2.step2View(widget);
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
            padding: widget.model.settingsCurrentRoute=="menu"?EdgeInsets.fromLTRB(0.03*width100, 0.0, 0.0, 20.0): EdgeInsets.all(0.0),
            child: new GestureDetector(
              onTap: (){
                print('card tapped');
                print(routerName);
                widget.model.recordSettingsRoute(routerName);
                if(routerName=='step1'){
                  var phone = new Phone.LocalPhoneStorage();
                  var requests = new Requests.POSTRequests();
                  waitForUserNumber() async{
                    var userNumber = await phone.readUserPhoneNumber();
                    print('value of userNumber after waiting, ');
                    print(userNumber);
                    var response = await requests.getUserData(userNumber);
                    await widget.model.setUserMongoose(response);
                  }
                  waitForUserNumber();
                }
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
