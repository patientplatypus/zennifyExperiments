
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';

class SettingsScreen extends StatelessWidget{
  final MainModel model;
  const SettingsScreen({
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
  const MySettingsScreen({
    Key key, 
    @required this.model, 
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _MySettingsScreen();
  }
}

class _MySettingsScreen extends State<MySettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new Material( 
      child: new Container(
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
      )
    );
  }
}

class RouterView extends State<MySettingsScreen>{
  @override
  Widget build(BuildContext context) {
    return new Container(

    );
  }
}

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
                    widget.model.changeStep1ChooseType("new_list");
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
                    widget.model.changeStep1ChooseType("view_lists");
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
          )
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
    if(widget.model.settingsCurrentRoute=='menu' || widget.model.settingsCurrentRoute==routerName){
      return new Container(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
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
      );
    }else{
      return new Container();
    }
  }
);
