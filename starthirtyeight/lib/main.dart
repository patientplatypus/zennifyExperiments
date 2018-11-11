import 'package:flutter/material.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';

import 'package:fluro/fluro.dart';

// Import my pages.
import 'package:starthirtyeight/components/screens/splash.dart';
import 'package:starthirtyeight/components/screens/about.dart';
import 'package:starthirtyeight/components/screens/settings.dart';
import 'package:starthirtyeight/components/screens/phone.dart';

import 'package:starthirtyeight/components/parts/bottombar.dart';
import 'package:starthirtyeight/components/parts/background.dart';

import 'package:starthirtyeight/globals/globals.dart' as globals;

import 'package:flutter/services.dart';

import 'package:starthirtyeight/HTTP/requests.dart';

import 'package:starthirtyeight/services/deviceinfo.dart';

void main() {

  //prevent orientation change on phone
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //spin up ZEIT server
  print('in main before spinRequest');
  var spin = new GETRequests();
  spin.spinRequest();

  //get Device Info
  //not currently operational -- see file
  // var dInfo = new DeviceInfo();
  // dInfo.getInfo();

  // Define our about page.
  globals.router.define('about', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    // return new AboutScreen();
    return new Stack(
      children: <Widget>[
        new BackgroundImage(),
        // new AboutScreen(),
        new BottomBar(model: BottombarModel())
      ], 
    );
  }));

  globals.router.define('settings', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    // return new SettingsScreen();
    return new Stack(
      children: <Widget>[
        // new BackgroundImage(),
        new SettingsScreen(model: MainModel()),
        new BottomBar(model: BottombarModel())
      ], 
    );
  }));

  // Define our home page.
  globals.router.define('home', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    // return new SplashScreen(model: CounterModel());
    return new Stack(
      children: <Widget>[
        // new BackgroundImage(),//set inside SplashScreen - not working here for some reason
        new SplashScreen(model: MainModel()),
        new BottomBar(model: BottombarModel())
      ], 
    );
  }));


  globals.router.define('phone', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    // return new PhoneScreen(model: PhoneModel());
    return new Stack(
      children: <Widget>[
        new BackgroundImage(),
        new PhoneScreen(model: MainModel()),
        new BottomBar(model: BottombarModel())
      ], 
    );
  }));


  runApp(
    new MaterialApp(
      home: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new SplashScreen(model: MainModel()),
          new BottomBar(model: BottombarModel())
        ], 
      ),
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: globals.router.generator
  ));

}