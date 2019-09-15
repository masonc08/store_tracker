import 'dart:convert';

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
  void send() {}
  String _entry = '';
  String _returned = '';
  String _address = '';
  List _serviceHours;

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
              Text('Enter the store name below:'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter store name here'),
                  onSubmitted: (value) {
                    updateText(value);
                    fetchLocation(value);
                  },
                ),
              ),
              Text(_entry),
              Text(_returned),
              Text(_address),
              Column(
                children: _serviceHours.cast<Widget>(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: send,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void updateText(text) {
    setState(() {
      text == '' ? _entry = '' : _entry = 'You entered: $text';
    });
  }

  void fetchLocation(value) async {
    //fetch and provide information for API returned location name and address
    String _key = 'AIzaSyANeaa3jm376zld-VkK5_YB7qyYQVMun7Q';
    String _placesUrl =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=$_key&input=$value&inputtype=textquery';
    http.Response _placesResponse = await http.post(_placesUrl);
    String _placeId = jsonDecode(_placesResponse.body.toString())['candidates']
        [0]['place_id'];
    String _placeDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?key=$_key&place_id=$_placeId';
    http.Response _placeDetailsResponse = await http.post(_placeDetailsUrl);
    String _foundResult =
        jsonDecode(_placeDetailsResponse.body.toString())['result']['name'];
    String _foundAddress =
        jsonDecode(_placeDetailsResponse.body.toString())['result']
            ['formatted_address'];
    setState(() {
      _returned = 'We found the following result: $_foundResult';
      _address = 'Address: $_foundAddress';
      if (jsonDecode(_placeDetailsResponse.body.toString())['result']['opening_hours'] == null){
        _serviceHours = [Text('No service hours found')];
      } else {
        _serviceHours = jsonDecode(_placeDetailsResponse.body.toString())['result']['opening_hours']['weekday_text'];
        for (int i = 0; i < _serviceHours.length; i++) {
          _serviceHours[i] = Text(_serviceHours[i]);
        }
        _serviceHours.add(
          RaisedButton(
            onPressed: _startTrack,
            child: Text('Track'),
          ),
        );
      }
    });
  }
  void _startTrack(){
    print('Test');
  }
}
