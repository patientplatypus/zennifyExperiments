
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starthirtyeight/scoped_state/scoped_state.dart';

class SplashScreen extends StatelessWidget {
  final CounterModel model;

  const SplashScreen({Key key, @required this.model}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: model,
      child: Scaffold(
        body: new MyHomePage(title: 'Flutter Demo Home Page')
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlatButton(
              onPressed: () {
                // Redirect to user "about" page.
                Navigator.pushReplacementNamed(context, 'about');
              },
              child: new Text('About')
            ),
            new Text(
              'You have pushed the button this many times:',
            ),
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) {
                return Text(
                  model.counter.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
          return FloatingActionButton(
            onPressed: model.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
} 
