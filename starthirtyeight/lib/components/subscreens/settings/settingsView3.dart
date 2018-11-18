
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
import 'package:intl/intl.dart';


var step3View = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SelectDateView(model: model)
        ],
      ),
    );
  }
);

class SelectDateView extends StatelessWidget {
  final MainModel model;
  
  SelectDateView({
    Key key, 
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: model,
      child: new MySelectDateView(model: model)
    );
  }
}

class MySelectDateView extends StatefulWidget {

  final MainModel model;

  MySelectDateView({
    Key key, 
    @required this.model, 
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _MySelectDateView();
  }
}

var prevDataCard = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){

    // String formattedDateEnd = DateFormat.yMMMMEEEEd().format(selectedDateEnd);

    returnData(dataType){
      for(var i = 0; i<widget.model.userMongoose.data['schema']['targetPhoneNumbers'].length; i++){
        if(widget.model.selectedListID==widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i]['_id']){
          if(dataType == 'timesPerDay'){
            return Text(
              widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i][dataType].toString() + " calls per day.",
              textAlign: TextAlign.start, 
              style: TextStyle(
                fontSize: 15.0, 
                color: Colors.white
              )
            );
          }else{
            print(widget.model.userMongoose.data['schema']);
            return Text(
              DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.model.userMongoose.data['schema']['targetPhoneNumbers'][i][dataType])), 
              textAlign: TextAlign.start, 
              style: TextStyle(
                fontSize: 15.0, 
                color: Colors.white
              )
            );
          }
        }else{
          return new Container();
        }
      }
      return new Container();
    }

    return new Card(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Current Call Settings",
                  style: TextStyle(
                    fontSize: 20.0, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white
                  )
                )
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Current Start Date: ", 
                textAlign: TextAlign.start, 
                style: TextStyle(
                  fontSize: 15.0, 
                  color: Colors.white
                )
              ),
              returnData('startDate'),
            ]
          ),
          Row(
            children: <Widget>[
              Text(
                "Current End Date: ", 
                textAlign: TextAlign.start, 
                style: TextStyle(
                  fontSize: 15.0, 
                  color: Colors.white
                )
              ),
              returnData('endDate')
            ]
          ), 
          Row(
            children: <Widget>[
              Text(
                "Current Call Frequency: ", 
                textAlign: TextAlign.start, 
                style: TextStyle(
                  fontSize: 15.0, 
                  color: Colors.white
                )
              ),
              returnData('timesPerDay')
            ]
          )
        ]
      )
    );
  }
);

var timesPicker = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){

    dateStringConverter(typeConvert, convertVal){
      if(typeConvert=='numberToString'){
        if(convertVal == 1){
          return "One Time per Day";
        }else if(convertVal==3){
          return "3 Times per Day";
        }else if(convertVal==5){
          return "5 Times per Day";
        }else if(convertVal==10){
          return "10 Times per Day";
        }
      }else if(typeConvert=='stringToNumber'){
        if(convertVal == "One Time per Day"){
          return 1;
        }else if(convertVal=="3 Times per Day"){
          return 3;
        }else if(convertVal=="5 Times per Day"){
          return 5;
        }else if(convertVal=="10 Times per Day"){
          return 10;
        }
      }else{
        return 0;
      }
    }

    dropDownFunc(){
      return new DropdownButton<String>(
        value: dateStringConverter('numberToString', widget.model.timesCallDay),
        items: <String>['One Time per Day', '3 Times per Day', '5 Times per Day', '10 Times per Day'].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(
              value, 
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
        onChanged: (e) {
          var numberVal = dateStringConverter('stringToNumber', e);
          widget.model.setTimesCallDay(numberVal);
          print('inside onChanged in dropDownFunc');
          print('value of e');
          print(e);
        },
      );
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(5.0)),
        dropDownFunc(),
        Padding(padding: EdgeInsets.all(5.0))
      ],
    );
  } 
);


var newSettingsButton = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    return new RaisedButton(
      color: Colors.red,
      onPressed: (){
        print('inside use new settings button onpressed');
        asyncCall() async{
          var requests = new Requests.POSTRequests();
          var response = await requests.updateCallTimes(widget.model.newStartDate, widget.model.newEndDate, widget.model.timesCallDay, widget.model.selectedListID, widget.model.userMongoose.data['schema']['_id']);
          print('after http request in button push value of response : ');
          print(response);
          widget.model.setUserMongoose(response);
          widget.model.setStep3Done(true);
          widget.model.recordSettingsRoute('step4');
        }
        asyncCall();
      },
      child: Container(
        child: Text(
          "Use New Settings",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black
          ),
        ),
      )
    );
  }
);


class _MySelectDateView extends State<MySelectDateView> {
  DateTime selectedDateStart = DateTime.now();
  DateTime selectedDateEnd = DateTime.now();
  String dropDownVal;

  Future<Null> _selectDate(BuildContext context, startEnd) async {
    var todayNow = DateTime.now();
    if (startEnd=='start'){
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: todayNow,
        firstDate: todayNow,
        lastDate: DateTime(2101));
      if (picked != null && picked != selectedDateStart){
        setState(() {
          selectedDateStart = picked;
        });
        widget.model.setNewStartDate(picked);
        print('difference Start - End times');
        print(selectedDateEnd.difference(selectedDateStart).inDays);
        if(selectedDateEnd.difference(selectedDateStart).inDays<0){
          selectedDateEnd = selectedDateStart;
          widget.model.setNewEndDate(selectedDateStart);
        }
      }
    }else if(startEnd=='end'){
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateStart,
        firstDate: selectedDateStart,
        lastDate: DateTime(2101));
      if (picked != null && picked != selectedDateEnd){
        setState(() {
          selectedDateEnd = picked;
        });
        widget.model.setNewEndDate(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    String formattedDateStart = DateFormat.yMMMMEEEEd().format(selectedDateStart);
    String formattedDateEnd = DateFormat.yMMMMEEEEd().format(selectedDateEnd);
    // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(selectedDate);
    if(widget.model.selectedListID==null||widget.model.userMongoose==null){
      return new Container(
        padding: EdgeInsets.all(20.0),
        child: Card(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child:Text(
              "Please complete Step 1 & 2. before moving on to Step 3.",
              style: TextStyle(
                fontSize: 40.0
              ),
              textAlign: TextAlign.center,
            ),
          )
        )
      );
    }else{
      return Container(
        height: 0.65*height100,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              prevDataCard(widget),
              Text(
                "New Call Settings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0, 
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),
              Card(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    // Padding(padding: EdgeInsets.all(2.0)),
                    Container(
                      child: Text(
                        "Start Date",
                        style: TextStyle(
                          fontSize: 20.0, 
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            formattedDateStart
                            // "${selectedDate.toLocal()}"
                          )
                        ),
                        RaisedButton(
                          onPressed: () => _selectDate(context, "start"),
                          child: Text('Select date'),
                        ),
                      ],
                    )
                  ],
                )
              ), 
              Card(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    // Padding(padding: EdgeInsets.all(2.0)),
                    Container(
                      child: Text(
                        "End Date",
                        style: TextStyle(
                          fontSize: 20.0, 
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            formattedDateEnd
                            // "${selectedDate.toLocal()}"
                          )
                        ),
                        RaisedButton(
                          onPressed: () => _selectDate(context, "end"),
                          child: Text('Select date'),
                        ),
                      ],
                    )
                  ],
                )
              ),
              Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Call Frequency",
                      style: TextStyle(
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 2.0)),
                    timesPicker(widget)
                  ],
                )
              ),
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.cyan,
                          onPressed: (){
                            print('inside keep current settings button onpressed');
                            widget.model.setStep3Done(true);
                            widget.model.recordSettingsRoute('step4');
                          },
                          child: Container(
                            child:  Text(
                              "Keep Current Settings",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black
                              ),
                            ),
                          )                     
                        ), 
                        Padding(padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0)),
                        newSettingsButton(widget),
                      ],
                    )
                  )
                )
              )
            ],
          ), 
        )
      );
    }
  }
}


