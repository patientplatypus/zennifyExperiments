import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluro/fluro.dart';

import 'package:starthirtyeight/globals/globals.dart' as globals;

import 'package:starthirtyeight/static_state/static_state.dart' as staticState;

class BottomBar extends StatelessWidget{
  final MainModel model;

  const BottomBar({
    Key key, 
    @required this.model 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ScopedModel<MainModel>(
      model: model,
      child: new MyBottomBar(model: model)
    );
  }
}

class MyBottomBar extends StatefulWidget {

  final MainModel model;

  const MyBottomBar({
    Key key, 
    @required this.model 
  }) : super(key: key);

  @override
  _MyBottomBar createState() => _MyBottomBar();
}

class _MyBottomBar extends State<MyBottomBar> with SingleTickerProviderStateMixin {
  AnimationController _controller;                                   
  Animation<Color> animationSelected;
  Animation<Color> animationDeselected;  
  
  @override
  initState() {
    super.initState();

    _controller = new AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    animationSelected = new ColorTween(
      begin: const Color.fromRGBO(0, 100, 200, 0.5),
      end: const Color.fromRGBO(0, 200, 100, 0.5),
    ).animate(_controller)
    ..addListener(() {
      setState((){});
    });

    animationDeselected = new ColorTween(
      begin: const Color.fromRGBO(0, 200, 100, 0.5),
      end: const Color.fromRGBO(0, 100, 200, 0.5)
    ).animate(_controller)
    ..addListener(() {
      setState((){});
    });

    _controller.forward();
  }

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  homeIcon(){
    if(staticState.currentRoute=='home'){
      return new Icon(
        FontAwesomeIcons.home, 
        color: animationSelected.value
      );
    }else if (staticState.prevRoute=='home' && staticState.currentRoute!='home'){
      return new Icon(
        FontAwesomeIcons.home, 
        color: animationDeselected.value
      );
    }else{
      print('inside else statement for home');
      return new Icon(
        FontAwesomeIcons.home, 
        color: const Color.fromRGBO(0, 100, 200, 0.5)
      );
    }
  }

    phoneIcon(){
    if(staticState.currentRoute=='phone'){
      return new Icon(
        FontAwesomeIcons.phone, 
        color: animationSelected.value
      );
    }else if (staticState.prevRoute=='phone' && staticState.currentRoute!='phone'){
      return new Icon(
        FontAwesomeIcons.phone, 
        color: animationDeselected.value
      );
    }else{
      print('inside else statement for phone');
      return new Icon(
        FontAwesomeIcons.phone, 
        color: const Color.fromRGBO(0, 100, 200, 0.5)
      );
    }
  }

    settingsIcon(){
    if(staticState.currentRoute=='settings'){
      return new Icon(
        FontAwesomeIcons.rocket, 
        color: animationSelected.value
      );
    }else if (staticState.prevRoute=='settings' && staticState.currentRoute!='settings'){
      return new Icon(
        FontAwesomeIcons.rocket, 
        color: animationDeselected.value
      );
    }else{
      print('inside else statement for settings');
      return new Icon(
        FontAwesomeIcons.rocket, 
        color: const Color.fromRGBO(0, 100, 200, 0.5)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width100 = MediaQuery.of(context).size.width;
    return new Positioned(
      bottom: 0.0,
      left: 0.0,
      child: new Material(
        child: new Container(
          width: width100,
          height: 80.0,
          // decoration: new BoxDecoration(color: Colors.red),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Expanded(
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black87),
                  child: new IconButton(
                    icon: homeIcon(), 
                    onPressed: () { 
                      print("Pressed 1");
                      globals.router.navigateTo(context, "home", transition: TransitionType.fadeIn);
                      staticState.recordRoute('home');
                      // Navigator.pushReplacementNamed(context, 'home');
                    }
                  )
                )
              ),
              new Expanded(
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black87),
                  child:  new IconButton(
                    icon: phoneIcon(), 
                    onPressed: () { 
                      print("Pressed 2");
                      globals.router.navigateTo(context, "phone", transition: TransitionType.fadeIn);
                      staticState.recordRoute('phone');
                      // Navigator.pushReplacementNamed(context, 'phone');
                    }
                  )
                )
              ),
              new Expanded(
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black87),
                  child: new IconButton(
                    icon: settingsIcon(), 
                    onPressed: () { 
                      print("Pressed 3");
                      globals.router.navigateTo(context, "settings", transition: TransitionType.fadeIn);
                      staticState.recordRoute('settings');
                      // Navigator.pushReplacementNamed(context, 'settings');
                    }
                  )
                )
              ),
            ]
          )
        )
      )
    );
  }
}

