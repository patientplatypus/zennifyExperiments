
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';

class SettingsScreen extends StatelessWidget{
  final SettingsModel model;
  const SettingsScreen({
    Key key, 
    @required this.model, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ScopedModel<SettingsModel>(
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
      child: Container(
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
            Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Step 1.", 
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.red,
                      )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Create Or Select Phone List", 
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.cyan,
                      )
                    )
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Step 2.", 
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.red,
                      )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Add Numbers To List", 
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.cyan,
                      )
                    )
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Step 3.", 
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.red,
                      )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Choose Message and Times", 
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.cyan,
                      )
                    )
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Step 4.", 
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.red,
                      )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Fire Ma' Lazers!", 
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.cyan,
                      )
                    )
                  )
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}
