import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Store Tracker'),
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
  void send(){}
  String entry = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Enter the store name below:'
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter store name here'
                  ),
                  onSubmitted: (value) {
                    updateText(value);
                  },
                ),
              ),
//              FutureBuilder(
//                future: _loadLocation(),
//                builder: (context, future) {
//                  return null;
//                }
//              ),
                Text(entry),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: send,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void updateText(text){
    setState(() {
      text == '' ? entry = '' : entry = 'You entered $text';
    });
  }
  Future<String> _loadLocation(value) {

  }
}
