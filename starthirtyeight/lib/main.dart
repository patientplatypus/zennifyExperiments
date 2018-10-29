import 'package:flutter/material.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';

import 'package:fluro/fluro.dart';

// Import my pages.
import 'package:starthirtyeight/components/screens/splash.dart';
import 'package:starthirtyeight/components/screens/about.dart';
import 'package:starthirtyeight/components/screens/phone.dart';


// final router = Router(); 

// import 'components/screens/splash.dart';

void main() {

  // Create the router.
  Router router = new Router();
  
  // Define our about page.
  router.define('about', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new AboutScreen();
  }));

  // Define our home page.
  router.define('home', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SplashScreen(model: CounterModel());
  }));


  router.define('phone', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new PhoneScreen();
  }));



  runApp(
    new MaterialApp(
      // home:  new SplashScreen(model: CounterModel()),
      home: new PhoneScreen(),
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generator
  ));
}