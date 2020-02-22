import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connectivity Stream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Connectivity Stream'),
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
  final String _userData = "https://jsonplaceholder.typicode.com/users";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<ConnectivityResult> _subscription;

  Future _getUserData() async {
    Response response = await get(_userData);
    if (response.statusCode == HttpStatus.ok) {
      var result = jsonDecode(response.body);
      return result;
    }
  }

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          _isThereConnectivity(true);
          break;
        case ConnectivityResult.none:
          _isThereConnectivity(false);
          break;
        default:
      }
    });
  }


  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _isThereConnectivity(bool param0) {
    if (param0) {
      setState(() {});
    } else {
      _scaffoldKey.currentState
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text("There's no connectivity...")));
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
        body: FutureBuilder(
          future: _getUserData(),
          builder: (context, result) {
            print("DATA: "+result.data.toString());
            if(result.data != null) {
              return ListView.builder(
                  itemCount: (result.data as List).length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text("${result.data[index]['name']}"),
                        subtitle: Text("${result.data[index]['phone']}"),
                      ),
                    );
                  });
            } else {
              return Column(
                children: <Widget>[
                  SizedBox(height: 24,),
                  Text("Loading"),
                  SizedBox(height: 24,),
                ],
              );
            }
          },
        )
    );
  }
}
