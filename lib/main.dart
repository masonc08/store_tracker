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
  void send(){}
  String _entry = '';
  String _returned = '';
  String _address = '';
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
                    fetchLocation(value);
                  },
                ),
              ),
              Text(_entry),
//              FutureBuilder(
//                future: _loadLocation(),
//                builder: (context, future) {
//                  return null;
//                }
//              ),
              Text(_returned),
              Text(_address),
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
  void updateText(text){
    setState(() {
      text == '' ? _entry = '' : _entry = 'You entered: $text';
    });
  }
  void fetchLocation(value) async{
    String _key = 'AIzaSyANeaa3jm376zld-VkK5_YB7qyYQVMun7Q';
    String _placesUrl = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=$_key&input=$value&inputtype=textquery';
    http.Response _placesResponse = await http.post(_placesUrl);
    String _placeId = jsonDecode(_placesResponse.body.toString())['candidates'][0]['place_id'];
    String _placeDetailsUrl = 'https://maps.googleapis.com/maps/api/place/details/json?key=$_key&place_id=$_placeId';
    http.Response _placeDetailsResponse = await http.post(_placeDetailsUrl);
    String _foundResult = jsonDecode(_placeDetailsResponse.body.toString())['result']['name'];
    String _foundAddress = jsonDecode(_placeDetailsResponse.body.toString())['result']['formatted_address'];
    setState(() {
      _returned = 'We found the following result: $_foundResult';
      _address = 'Address: $_foundAddress';
    });
  }
}
