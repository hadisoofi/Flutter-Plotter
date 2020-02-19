import 'package:flutter/material.dart';
import 'package:plotter_app/sin_plotter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _frequency = 1;

  void _incrementFrequency() {
    setState(() {
      _frequency += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SinPlotter(_frequency),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementFrequency,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
