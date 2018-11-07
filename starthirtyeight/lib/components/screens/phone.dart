import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:starthirtyeight/scoped_state/scoped_state.dart';
import 'package:starthirtyeight/components/parts/phonepad.dart';
import 'package:starthirtyeight/components/parts/totalnum.dart'; 
import 'package:starthirtyeight/HTTP/requests.dart';


class PhoneScreen extends StatelessWidget {
  final MainModel model;
  const PhoneScreen({
    Key key, 
    @required this.model, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ScopedModel<MainModel>(
      model: model,
      child: new MyPhoneScreen(model: model)
    );
  }
}

class MyPhoneScreen extends StatefulWidget {
  final MainModel model;
  const MyPhoneScreen({
    Key key, 
    @required this.model, 
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _MyPhoneScreenState();
  }
}

class _MyPhoneScreenState extends State<MyPhoneScreen> {

  @override
  void initState() {
    super.initState();
    print('inside initstate in phone');
    print(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(color: new Color.fromRGBO(0, 0, 0, 0.0)),
        // child: new Text('You are on the Phone Screen')
        child: Column(
          children: <Widget>[
            new Container(
              height: 100.0, 
              // decoration: BoxDecoration(color: Colors.blue[500])
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new MyTotalnum(model: widget.model),
                )
              ],
            ),
            new Container(
              height: 50.0, 
              // decoration: BoxDecoration(color: Colors.blue[500])
            ),
            new MyPhonePad(model: widget.model),
            new Padding(
              padding: EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new MaterialButton(
                      color: Colors.black87,
                      height: 100.0,
                      child: Text(
                        'Upload to Ion Cannon',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.cyan,
                        ),
                        textAlign: TextAlign.center
                      ),
                      onPressed: (){
                        print('ion cannon pressed');
                        // var requests = new GETRequests();
                        // requests.testRequest();
                        var requests = new POSTRequests();
                        requests.addUserNumber(widget.model.callNumber);
                      }
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new Expanded(
                    child: new MaterialButton(
                      color: Colors.black87,
                      height: 100.0,
                      child: Text(
                        'Initiate Satellite Uplink',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.cyan,
                        ),
                        textAlign: TextAlign.center
                      ),
                      onPressed: (){
                        print('satellite uplink pressed');
                        var launchString = 'tel://'+widget.model.callNumber;
                        launch(launchString);
                      }
                    ),
                  )
                ],
              )
            )
          ]
        )
    );
  }
}