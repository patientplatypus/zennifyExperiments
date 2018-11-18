
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


var step4View = (widget) => ScopedModelDescendant<MainModel>(
  builder: (context, child, model){
    return new Container(
      color: Colors.white,
      child: Text("hello there sailor"),
    );
  }
);